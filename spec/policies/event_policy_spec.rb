require 'rails_helper'

RSpec.describe EventPolicy, type: :policy do
  subject { described_class.new(admin, event) }
  let!(:user) { create(:user) }
  let(:event) { create(:event, user: user) }

  context 'for a moderator' do
    let(:admin) { create(:admin, :moderator) }

    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:pending) }
    it { is_expected.to permit_action(:show)    }
    it { is_expected.to permit_action(:create)  }
    it { is_expected.to permit_action(:update)  }
    it { is_expected.to permit_action(:edit)    }
    it { is_expected.not_to permit_action(:destroy) }
  end

  context 'for a superadmin' do
    let(:admin) { create(:admin) }

    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:pending) }
    it { is_expected.to permit_action(:show)    }
    it { is_expected.to permit_action(:create)  }
    it { is_expected.to permit_action(:update)  }
    it { is_expected.to permit_action(:edit)    }
    it { is_expected.to permit_action(:destroy) }
  end
end
