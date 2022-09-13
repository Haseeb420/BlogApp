# frozen_string_literal: true

class CommentLikesController < ApplicationController
  before_action :set_comment, except: [:destory]
  before_action :new_comment_like
  def index
    if Comment.user_exists?
      Comment.delete_user_comment_like
    else
      @comment_like.comment_id = @comment.id
      @comment_like.user_id = current_user.id
      @comment_like.save
    end
    respond_to do |format|
      format.js
    end
  end

  def destory
    Comment.delete_user_comment_like
  end

  private

  def comment_like_params
    params.require(:comment_like).permit(:post_id, :user_id)
  end

  def set_comment
    @comment = Comment.find(params[:comment_id])
  end

  def new_comment_like
    @comment_like = CommentLike.new
  end
end
