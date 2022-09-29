# frozen_string_literal: true

FactoryBot.define do
  factory :reported_post do
    user_id { 1 }
    post_id { 1 }
    reason { "Some reason" }
  end
end
