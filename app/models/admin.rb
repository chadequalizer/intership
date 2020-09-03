class Admin < ApplicationRecord
  include AASM

  aasm column: :role do
    state :superadmin, initial: true
    state :moderator

    event :change_to_superadmin do
      transitions from: :moderator, to: :superadmin
    end

    event :change_to_moderator do
      transitions from: :superadmin, to: :moderator
    end
  end

  paginates_per 10

  devise :database_authenticatable,
         :rememberable, :validatable
end
