require 'rails_helper'

RSpec.describe Admin::TagsController do
  login_admin
  subject { response }

  describe 'GET #index' do
    before { get :index }

    it { is_expected.to render_template :index }
  end

  describe 'GET #new' do
    before { get :new }

    it { is_expected.to render_template :new }
  end

  describe 'GET #edit' do
    let(:tag) { create(:tag) }
    before { get :edit, params: { id: tag.id } }

    it { is_expected.to render_template :edit }
  end

  describe 'POST #create' do
    let(:attrs) { attributes_for(:tag) }

    it 'creates new tag' do
      expect do
        post :create, params: { tag: attrs }
      end.to change(Tag.all, :count).by(1)
    end

    it 'redirect to #index' do
      post :create, params: { tag: attrs }
      expect(response).to redirect_to admin_tags_path
    end
  end

  describe 'PATCH #update' do
    let(:attrs) { attributes_for(:tag, :valid_edit) }
    let(:tag) { create(:tag) }

    it 'updates tag' do
      patch :update, params: { id: tag.id, tag: attrs }
      expect(Tag.last.name).to eq attrs[:name]
    end

    it 'redirect to index' do
      patch :update, params: { id: tag.id, tag: attrs }
      expect(response).to redirect_to admin_tags_path
    end
  end

  describe 'DELETE #destroy' do
    let!(:tag) { create(:tag) }

    it 'deletes tag' do
      expect do
        delete :destroy, params: { id: tag.id }
      end.to change(Tag.all, :count).by(-1)
    end
  end
end
