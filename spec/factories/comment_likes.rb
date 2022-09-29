# frozen_string_literal: true

FactoryBot.define do
  factory :comment_like do
    comment_id { 1 }
    user_id { 1 }
  end
end
