# frozen_string_literal: true

class PostLike < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def user_post_like_exists?(user_id, post_id)
    PostLike.find_by("user_id=? and post_id=?", user_id, post_id).exists?
  end

  def delete_post_like
    PostLike.find_by("user_id=? and post_id=?", user_id, post_id).delete
  end
end
