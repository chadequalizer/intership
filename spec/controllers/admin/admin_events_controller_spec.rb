require 'rails_helper'

RSpec.describe Admin::EventsController do
  describe 'GET #index' do
    context 'for logged in' do
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
  end

  describe 'GET #edit' do
    context 'admin signed in' do
      login_admin
      let!(:user) { create(:user) }
      let!(:event) { create(:event, user: user) }

      it 'renders #edit form' do
        get :edit, params: { id: Event.last.id }
        expect(response).to render_template('edit')
      end
    end

    context 'not signed in' do
      let!(:user) { create(:user) }
      let!(:event) { create(:event, user: user) }

      it 'redirect to sign in' do
        get :edit, params: { id: Event.last.id }
        expect(response).to redirect_to('/admins/sign_in')
      end
    end
  end

  describe 'PATCH #update' do
    context 'valid attributes' do
      login_admin
      let(:attrs) { attributes_for(:event, :valid_edit) }
      let!(:user) { create(:user) }
      let!(:event) { create(:event, user: user) }

      it 'updates event' do
        patch :update, params: { id: Event.last.id, event: attrs }
        expect(Event.last.title).to eq attrs[:title]
      end

      it 'redirect to show' do
        patch :update, params: { id: Event.last.id, event: attrs }
        expect(response).to redirect_to action: :show,
                                        id: assigns(:event).id
      end
    end

    context 'invalid attributes' do
      login_admin
      let(:attrs) { attributes_for(:event, :invalid) }
      let!(:user) { create(:user) }
      let!(:event) { create(:event, user: user) }

      it 'render edit form' do
        patch :update, params: { id: Event.last.id, event: attrs }
        expect(response).to render_template('edit')
      end
    end

    context 'not signed in' do
      let(:attrs) { attributes_for(:event) }
      let!(:user) { create(:user) }
      let!(:event) { create(:event, user: user) }

      it 'redirect to sign in' do
        patch :update, params: { id: Event.last.id, event: attrs }
        expect(response).to redirect_to('/admins/sign_in')
      end
    end
  end

  describe 'DELETE #destroy' do
    login_admin
    let!(:user) { create(:user) }
    let!(:event) { create(:event, user: user) }

    it 'deletes event' do
      expect do
        delete :destroy, params: { id: Event.last.id }
      end.to change(Event.all, :count).by(-1)
    end

    it 'wont deletes event without login' do
      sign_out :admin
      expect do
        delete :destroy, params: { id: Event.last.id }
      end.to change(Event.all, :count).by(0)
    end
  end
end
