FactoryBot.define do
  factory :user do
    sequence(:email)               { |n| "user#{n}@example.com" }
    sequence(:password)            { |n| "password#{n}" }
  end

  factory :admin do
    sequence(:email)               { |n| "user#{n}@example.com" }
    sequence(:password)            { |n| "password#{n}" }
    role { 'superadmin' }

    trait :moderator do
      role { 'moderator' }
    end

    trait :invalid do
      email { 'qwe123' }
    end

    trait :valid_edit do
      email { 'new_mail@gmail.com' }
    end
  end

  factory :event do
    title { 'new_title' }
    start_time { DateTime.now + 1.hour }
    end_time { DateTime.now + 2.hours }
    state { 'pending' }
    description { 'His dudeness, duder, or el dudorino' }

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

  factory :tag do
    sequence(:name) { |n| "tag#{n}" }
    keywords { 'keyword, duder' }

    trait :valid_edit do
      name { 'new_name' }
    end
  end
end
