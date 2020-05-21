FactoryBot.define do
  factory :event do
    title { 'new_title' }
    start_time { DateTime.now + 1.hour }
    end_time { DateTime.now + 2.hours }

    trait :invalid do
      title {}
      start_time { DateTime.now + 1.hour }
      end_time { DateTime.now + 2.hours }
    end

    trait :valid_edit do
      title { 'very_new_title' }
      start_time { DateTime.now + 1.hour }
      end_time { DateTime.now + 2.hours }
    end
  end
end
