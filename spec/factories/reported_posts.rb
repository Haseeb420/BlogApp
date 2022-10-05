# frozen_string_literal: true

FactoryBot.define do
  factory :reported_post do
    association :user
    association :post
    reason { Faker::Lorem.characters(number: 20) }
  end
end
