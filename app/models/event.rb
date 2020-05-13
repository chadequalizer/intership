class Event < ApplicationRecord
  validates :title, presence: {message: "Must be given"}
  validates :organizer_email, format: {with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message: "Invalid email adress"}, allow_blank: true
  validates :organizer_telegram, format: {with: /@.+/i, message: "Invalid telegram"}, allow_blank: true
  validate :start_before_end
  paginates_per 5

  def start_before_end
    if start_time > end_time 
      errors.add(:start_time, "Must be before End Time")
    end
  end
end
