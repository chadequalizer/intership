require 'rails_helper'

RSpec.describe AdminPolicy, type: :policy do
  subject { described_class.new(admin, admin_user) }
  let(:admin_user) { create(:admin) }

  context 'for a moderator' do
    let(:admin) { create(:admin, :moderator) }

    it { is_expected.not_to permit_action(:index) }
    it { is_expected.not_to permit_action(:show)    }
    it { is_expected.not_to permit_action(:create)  }
    it { is_expected.not_to permit_action(:new)     }
    it { is_expected.not_to permit_action(:update)  }
    it { is_expected.not_to permit_action(:edit)    }
    it { is_expected.not_to permit_action(:destroy) }
  end

  context 'for a superadmin' do
    let(:admin) { create(:admin) }

    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:show)    }
    it { is_expected.to permit_action(:create)  }
    it { is_expected.to permit_action(:new)     }
    it { is_expected.to permit_action(:update)  }
    it { is_expected.to permit_action(:edit)    }
    it { is_expected.to permit_action(:destroy) }
  end
end
