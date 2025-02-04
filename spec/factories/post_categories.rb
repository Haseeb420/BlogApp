# frozen_string_literal: true

FactoryBot.define do
  factory :post_category do
    category_name { Faker::Name.name }
  end
end
