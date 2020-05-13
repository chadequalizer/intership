require 'spec_helper'

RSpec.describe EventsController do

  describe 'GET #index' do
    it 'render index' do 
      get :index
      expect(response).to render_template('index')
    end
  end
end