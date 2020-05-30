class Event < ApplicationRecord
  belongs_to :user
  validates :title, presence: { message: :invalid_title }
  validates :organizer_email, format: {
    with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i,
    message: :invalid_email
  }, allow_blank: true
  validates :organizer_telegram, format: { with: /@.+/i,
                                           message: :invalid_telegram },
                                 allow_blank: true
  validate :start_before_end
  paginates_per 5

  def start_before_end
    errors.add(:start_time, :start_before_end) if start_time > end_time
  end
end
