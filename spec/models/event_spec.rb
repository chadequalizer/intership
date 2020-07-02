require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validations' do
    let!(:user) { create(:user) }
    subject { build(:event, user: user) }

    it 'is valid with valid attrs' do
      expect(subject).to be_valid
    end

    it 'is not valid without title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'start time less than end time' do
      subject.end_time = Time.now
      expect(subject).to_not be_valid
    end
  end

  describe 'states' do
    let!(:user) { create(:user) }
    let!(:admin) { create(:admin) }
    subject { build(:event, user: user) }

    context 'when created' do
      it 'has pending state' do
        expect(subject).to have_state(:pending)
      end
    end

    context 'transitions from pending' do
      it 'transit to approved' do
        expect(subject).to transition_from(:pending).to(:approved).on_event(:approve)
      end

      it 'transit to declined' do
        expect(subject).to transition_from(:pending).to(:declined).on_event(:decline)
      end
    end

    context 'cant transist from final state' do
      it 'when approved' do
        subject.approve!
        expect(subject).to_not allow_transition_to(:approve)
        expect(subject).to_not allow_transition_to(:decline)
        expect(subject).to_not allow_transition_to(:pending)
      end

      it 'when decline' do
        subject.decline!
        expect(subject).to_not allow_transition_to(:approve)
        expect(subject).to_not allow_transition_to(:decline)
        expect(subject).to_not allow_transition_to(:pending)
      end
    end
  end
end
