# frozen_string_literal: true

FactoryBot.define do
  factory :post_like do
    association :user
    association :post
  end
end
