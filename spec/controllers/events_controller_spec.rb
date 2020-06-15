require 'rails_helper'

RSpec.describe EventsController do
  describe 'GET #index' do
    context 'for logged in' do
      login_user
      it 'render index' do
        get :index
        expect(response).to render_template('index')
      end
    end

    context 'not signed in' do
      it 'redirect to sign_in' do
        get :index
        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end

  describe 'GET #new' do
    context 'sigined in' do
      login_user
      it 'render new' do
        get :new
        expect(response).to render_template('new')
      end
    end

    context 'not signed in' do
      it 'redirect to sign_in' do
        get :new
        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end

  describe 'POST #create' do
    context 'valid attributes' do
      login_user
      let(:attrs) { attributes_for(:event) }

      it 'creates new event' do
        expect do
          post :create, params: { event: attrs }
        end.to change(Event.all, :count).by(1)
      end

      it 'redirects to #show' do
        post :create, params: { event: attrs }
        expect(response).to redirect_to action: :show,
                                        id: assigns(:event).id
      end
    end

    context 'invalid attributes' do
      login_user
      let(:attrs) { attributes_for(:event, :invalid) }

      it 'renders #new form' do
        post :create, params: { event: attrs }
        expect(response).to render_template('new')
      end
    end

    context 'not signed in' do
      let(:attrs) { attributes_for(:event) }

      it 'wont create new event' do
        expect do
          post :create, params: { event: attrs }
        end.to change(Event.all, :count).by(0)
      end
    end
  end

  describe 'GET #edit' do
    context 'user signed in' do
      login_user
      let!(:event) { create(:event, :approved, user: subject.current_user) }

      it 'renders #edit form' do
        get :edit, params: { id: Event.last.id }
        expect(response).to render_template('edit')
      end
    end

    context 'not signed in' do
      let(:attrs) { attributes_for(:event, :valid_edit) }
      let!(:user) { create(:user) }
      let!(:event) { create(:event, user: user) }

      it 'redirect to sign in' do
        patch :update, params: { id: Event.last.id, event: attrs }
        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end

  describe 'PATCH #update' do
    context 'valid attributes' do
      login_user
      let(:attrs) { attributes_for(:event, :valid_edit) }
      let!(:event) { create(:event, :approved, user: subject.current_user) }

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
      login_user
      let(:attrs) { attributes_for(:event, :invalid) }
      let!(:event) { create(:event, :approved, user: subject.current_user) }

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
        expect(response).to redirect_to('/users/sign_in')
      end
    end

    context 'wrong owner' do
      login_user
      let(:attrs) { attributes_for(:event, :valid_edit) }
      let!(:user) { create(:user) }
      let!(:event) { create(:event, user: user) }

      it 'wont updates event' do
        patch :update, params: { id: Event.last.id, event: attrs }
        expect(Event.last.title).not_to eq attrs[:title]
      end

      it 'redirect to index' do
        patch :update, params: { id: Event.last.id, event: attrs }
        expect(response).to redirect_to events_path
      end
    end
  end

  describe 'DELETE #destroy' do
    login_user
    let!(:event) { create(:event, :approved, user: subject.current_user) }

    it 'deletes event' do
      expect do
        delete :destroy, params: { id: Event.last.id }
      end.to change(Event.all, :count).by(-1)
    end

    it 'wont deletes event without login' do
      sign_out :user
      expect do
        delete :destroy, params: { id: Event.last.id }
      end.to change(Event.all, :count).by(0)
    end
  end
end
