# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  has_many :comment_likes, dependent: :delete_all
  belongs_to  :parent, class_name: "Comment", optional: true
  has_many    :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy

  validates :body, presence: true
  validates :user_id, presence: true
  validates :post_id, presence: true

  def user_comment_like_exists?(user_id)
    comment_likes.where("user_id=?", user_id).exists?
  end

  def delete_user_comment_like(user_id)
    comment_likes.where("user_id=?", user_id).first.delete
  end

  def add_user_comment_like(user_id)
    @comment_like = comment_likes.build
    @comment_like.user_id = user_id
    @comment_like.save
    @comment_like
  end
end
