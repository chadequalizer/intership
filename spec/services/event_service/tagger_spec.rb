require 'rails_helper'

RSpec.describe EventService::Tagger do
  describe 'when event created' do
    let(:user) { create(:user) }
    let(:event) { create(:event, user: user) }
    let!(:tag) { create(:tag) }

    it 'autoassigns tags' do
      described_class.call(event)
      expect(Event.last.tag_list.to_s).to include(tag.name)
    end

    it 'doesnt autoassigns tags without description' do
      event.description = {}
      described_class.call(event)
      expect(Event.last.tag_list.to_s).to_not include(tag.name)
    end
  end
end
