# frozen_string_literal: true

class CommentLike < ApplicationRecord
  belongs_to :comment
  belongs_to :user

  def i_am_doing_Something
    puts "asdasd"
  end

  def user_exists?(user_id, comment_id)
    CommentLike.where("user_id=? and comment_id=?", user_id, comment_id).exists?
  end

  def delete_user_comment_like(user_id, comment_id)
    CommentLike.where("user_id=? and comment_id=?", user_id, comment_id).first.delete
  end
end
