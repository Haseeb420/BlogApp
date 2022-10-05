# frozen_string_literal: true

FactoryBot.define do
  factory :comment_like do
    association :comment
    association :user
  end
end
