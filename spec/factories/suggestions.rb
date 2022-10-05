# frozen_string_literal: true

FactoryBot.define do
  factory :suggestion do
    body { Faker::Lorem.characters(number: 20) }
    association :post
  end
end
