require 'rails_helper'

RSpec.describe EventsController do
  describe 'GET #index' do
    it 'render index' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET #new' do
    it 'render new' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    context 'valid attributes' do
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
      let(:attrs) { attributes_for(:event, :invalid) }

      it 'renders #new form' do
        post :create, params: { event: attrs }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'GET #edit' do
    let(:attrs) { attributes_for(:event) }
    let!(:event) { create(:event) }

    it 'renders #edit form' do
      get :edit, params: { id: Event.last.id }
      expect(response).to render_template('edit')
    end
  end

  describe 'PATCH #update' do
    context 'valid attributes' do
      let(:attrs) { attributes_for(:event, :valid_edit) }
      let!(:event) { create(:event) }

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
      let(:attrs) { attributes_for(:event, :invalid) }
      let!(:event) { create(:event) }

      it 'render edit form' do
        patch :update, params: { id: Event.last.id, event: attrs }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    before { post :create, params: { event: attributes_for(:event) } }

    it 'deletes event' do
      expect do
        delete :destroy, params: { id: Event.last.id }
      end.to change(Event.all, :count).by(-1)
    end
  end
end
