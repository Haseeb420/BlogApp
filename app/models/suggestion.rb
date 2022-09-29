# frozen_string_literal: true

class Suggestion < ApplicationRecord
  belongs_to :post
  validates :body, presence: true
  validates :post_id, presence: true
  scope :all_suggestions, -> { Suggestion.all.order(created_at: :desc) }
end
