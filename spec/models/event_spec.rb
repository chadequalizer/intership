require 'rails_helper'

RSpec.describe Event, type: :model do
  let!(:user) { create(:user) }
  subject { build(:event, user: user) }

  it 'is valid with valid' do
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
