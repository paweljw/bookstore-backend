# frozen_string_literal: true

FactoryGirl.define do
  factory :author do
    name { Faker::Name.name }
  end
end
