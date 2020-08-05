FactoryBot.define do
  factory :user do
    sequence(:email)               { |n| "user#{n}@example.com" }
    sequence(:password)            { |n| "password#{n}" }
  end

  factory :admin do
    sequence(:email)               { |n| "user#{n}@example.com" }
    sequence(:password)            { |n| "password#{n}" }
    role { 'superadmin' }
  end

  factory :event do
    title { 'new_title' }
    start_time { DateTime.now + 1.hour }
    end_time { DateTime.now + 2.hours }
    state { 'pending' }

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

    trait :approved do
      state { 'approved' }
    end
  end
end
