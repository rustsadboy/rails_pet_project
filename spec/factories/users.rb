# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { FFaker::Name.name }
    email { FFaker::Internet.email }
    password { 'ulitka_ulitochka_228' }
    age { 'under16' }
    gender { 'male' }
    registration_completed { true }
    email_confirmed { true }
    search_id { FFaker::Number.unique.rand(10_000..99_999) }

    trait :with_recovery do
      recovery_password_expired_at { DateTime.now + 1.hour }
    end

    traits_for_enum(:gender, %i[male female])
    traits_for_enum(:age, %i[under16 16-19 20-25 26-40 over40])
  end
end
