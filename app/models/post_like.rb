# frozen_string_literal: true

class PostLike < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :user_id, presence: true
  validates :post_id, presence: true

  # scope :user_like_exists, -> { where(:attibute => value post_like:{user_id: })}
  # Ex:- scope :active, -> {where(:active => true)}

  def user_post_like_exists?(user_id, post_id)
    post_likes.find_by("user_id=? and post_id=?", user_id, post_id).exists?
  end

  def delete_post_like
    PostLike.find_by("user_id=? and post_id=?", user_id, post_id).delete
  end
end
