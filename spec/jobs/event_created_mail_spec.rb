require 'rails_helper'

RSpec.describe EventCreatedMail do
  let!(:user) { create(:user) }
  let!(:event) { build(:event, user: user) }
  let!(:admin) { create(:admin) }

  it 'deliver mail' do
    expect do
      described_class.run(event)
    end.to change(ActionMailer::Base.deliveries, :count).by(1)
  end
end
