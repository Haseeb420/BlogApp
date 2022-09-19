# frozen_string_literal: true

class Suggestion < ApplicationRecord
  belongs_to :post

  scope :all_suggestions, -> { Suggestion.all.order(created_at: :desc)}
  # Ex:- scope :active, -> {where(:active => true)}
end
