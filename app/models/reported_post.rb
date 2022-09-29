# frozen_string_literal: true

class ReportedPost < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :reason, presence: true
end
