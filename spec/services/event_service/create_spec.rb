require 'rails_helper'

RSpec.describe EventService::Create do
  describe 'new event' do
    context 'valid params' do
      let!(:user) { create(:user) }
      let(:attrs) { attributes_for(:event) }

      it 'creates new event' do
        expect do
          described_class.call(user, attrs)
        end.to change(Event.all, :count).by(1)
      end

      it 'assignes event to user' do
        described_class.call(user, attrs)
        expect(Event.last.user_id).to eq(user.id)
      end

      it 'run mail job' do
        expect do
          described_class.call(user, attrs)
        end.to change(CreateAdminMailWorker.jobs, :size).by(1)
      end
    end

    context 'invalid params' do
      let!(:user) { create(:user) }
      let(:attrs) { attributes_for(:event, :invalid) }

      it 'wont creates new event' do
        expect do
          described_class.call(user, attrs)
        end.to change(Event.all, :count).by(0)
      end
    end
  end
end
