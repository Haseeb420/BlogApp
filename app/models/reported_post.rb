# frozen_string_literal: true

class ReportedPost < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :reason, presence: true
end
