require 'rails_helper'
require 'pry'

RSpec.describe AdminMailer, type: :mailer do
  describe 'notify admin' do
    context 'when event created' do
      let!(:admin) { create(:admin) }
      let!(:user) { create(:user) }
      let!(:event) { create(:event, user: user) }
      let(:mail) { described_class.new_event(event, admin.email).deliver_now }

      it 'assigns @admin_event_url' do
        expect(mail.body.encoded)
          .to match(admin_events_url)
      end

      it 'sends to admins email' do
        expect(mail.to).to eq([admin.email])
      end
    end
  end
end
