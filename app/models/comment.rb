# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  has_many :comment_likes, dependent: :delete_all
  belongs_to  :parent, class_name: "Comment", optional: true
  has_many    :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy

  validates :body, presence: true
end
