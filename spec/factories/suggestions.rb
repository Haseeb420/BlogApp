# frozen_string_literal: true

FactoryBot.define do
  factory :suggestion do
    body { "MyText" }
    post_id { 1 }
  end
end
