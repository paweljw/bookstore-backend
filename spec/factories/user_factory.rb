# frozen_string_literal: true

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'password123'

    trait :admin do
      admin true
    end
  end
end
