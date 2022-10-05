# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    association :post
    association :user
    body { Faker::Lorem.characters(number: 20) }
  end
end
