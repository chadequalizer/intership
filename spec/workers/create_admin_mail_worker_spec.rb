require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe CreateAdminMailWorker do
  subject { described_class.new }
  let!(:user) { create(:user) }
  let!(:event) { create(:event, user: user) }
  let!(:admin) { create(:admin) }

  context '#perform' do
    it 'notifies admin' do
      expect { subject.perform(event.id) }.to change(ActionMailer::Base.deliveries, :count).by(1)
    end
  end
end
