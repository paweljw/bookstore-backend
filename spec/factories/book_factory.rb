# frozen_string_literal: true

FactoryGirl.define do
  factory :book do
    title { Faker::Book.title }
    author
    price { rand * 15 }
  end
end
