class User < ApplicationRecord
  has_many :events
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
