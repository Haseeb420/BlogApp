# frozen_string_literal: true

class CommentLike < ApplicationRecord
  belongs_to :comment
  belongs_to :user

  validates :user_id, presence: true
  validates :comment_id, presence: true

  def user_exists?(user_id, comment_id)
    CommentLike.where("user_id=? and comment_id=?", user_id, comment_id).exists?
  end

  def delete_user_comment_like(user_id, comment_id)
    CommentLike.where("user_id=? and comment_id=?", user_id, comment_id).first.delete
  end
end
