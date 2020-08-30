require 'rails_helper'

RSpec.describe Admin::AdminsController do
  describe 'GET #index' do
    context 'for superadmin logged in' do
      login_admin
      it 'render index' do
        get :index
        expect(response).to render_template('index')
      end
    end

    context 'not signed in' do
      it 'redirect to sign_in' do
        get :index
        expect(response).to redirect_to('/admins/sign_in')
      end
    end

    context 'for moderator logged in' do
      login_moderator
      it 'redirect to index' do
        get :index
        expect(response).to redirect_to('/admin/events')
      end
    end
  end

  describe 'GET #new' do
    login_admin
    before { get :new }

    it { is_expected.to be_success }
    it { is_expected.to render_template :new }
  end

  describe 'GET #edit' do
    login_admin
    let!(:admin) { create(:admin) }
    before { get :edit, params: { id: admin.id } }

    it { is_expected.to be_success }
    it { is_expected.to render_template :edit }
  end

  describe 'POST #create' do
    login_admin

    context 'valid attributes' do
      let(:attrs) { attributes_for(:admin) }

      it 'creates new admin' do
        expect do
          post :create, params: { admin: attrs }
        end.to change(Admin.all, :count).by(1)
      end

      it 'redirect to #index' do
        post :create, params: { admin: attrs }
        expect(response).to redirect_to admin_admins_path
      end
    end

    context 'invalid attributes' do
      let(:attrs) { attributes_for(:admin, :invalid) }

      it 'renders #new form' do
        post :create, params: { admin: attrs }
        expect(response).to render_template('new')
      end

      it 'wont creates new admin' do
        expect do
          post :create, params: { admin: attrs }
        end.to change(Admin.all, :count).by(0)
      end
    end

    describe 'PATCH #update' do
      login_user

      context 'valid attributes' do
        let(:attrs) { attributes_for(:admin, :valid_edit) }
        let!(:admin) { create(:admin) }

        it 'updates admin' do
          patch :update, params: { id: admin.id, admin: attrs }
          expect(Admin.last.email).to eq attrs[:email]
        end

        it 'redirect to show' do
          patch :update, params: { id: admin.id, admin: attrs }
          expect(response).to redirect_to action: :show,
                                          id: assigns(:admin).id
        end
      end

      context 'invalid attributes' do
        let(:attrs) { attributes_for(:admin, :invalid) }
        let!(:admin) { create(:admin) }

        it 'render edit form' do
          patch :update, params: { id: admin.id, admin: attrs }
          expect(response).to render_template('edit')
        end

        it 'updates admin' do
          patch :update, params: { id: admin.id, admin: attrs }
          expect(Admin.last.email).to_not eq attrs[:email]
        end
      end
    end

    describe 'DELETE #destroy' do
      login_admin
      let!(:admin) { create(:admin) }

      it 'deletes admin' do
        expect do
          delete :destroy, params: { id: admin.id }
        end.to change(Admin.all, :count).by(-1)
      end
    end
  end
end
