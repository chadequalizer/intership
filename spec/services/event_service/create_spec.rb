require 'rails_helper'

RSpec.describe EventService::Create do
  describe 'new event' do
    context 'valid params' do
      let!(:user) { create(:user) }
      let(:attrs) { attributes_for(:event) }
      let!(:tag) { create(:tag) }

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

      it 'autoassigns tags' do
        described_class.call(user, attrs)
        expect(Event.last.tag_list.to_s).to include(tag.name)
      end
    end

    context 'invalid params' do
      let!(:user) { create(:user) }
      let(:attrs) { attributes_for(:event, :invalid) }

      it 'raise validation error' do
        expect do
          described_class.call(user, attrs)
        end.to raise_error('Validation failed: Title Must be given')
      end
    end
  end
end
