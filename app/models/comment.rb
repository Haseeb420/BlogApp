# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  belongs_to  :parent, class_name: 'Comment', optional: true
  has_many    :replies, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy
  has_many :comment_likes, dependent: :delete_all

  # methods related to comment model are defined here
  def user_exists?
    CommentLike.where('user_id=? and comment_id=?', current_user.id, params[:comment_id]).exists?
  end

  def delete_user_comment_like
    CommentLike.where('user_id=? and comment_id=?', current_user.id, params[:comment_id]).first.delete
  end
end
