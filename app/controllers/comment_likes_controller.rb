# frozen_string_literal: true

class CommentLikesController < ApplicationController
  before_action :set_comment, except: [:destory]

  def index
    if @comment.user_comment_like_exists?(current_user.id)
      @comment.delete_user_comment_like(current_user.id)
    else
      @comment.add_user_comment_like(current_user.id)
    end
    respond_to do |format|
      format.json { }
      format.js { @comment }
    end
  end

  def destory
    @comment_like_instance.delete_user_comment_like(current_user.id, @comment.id)
  end

  private
    def comment_like_params
      params.require(:comment_like).permit(:post_id, :user_id)
    end

    def set_comment
      @comment = Comment.find(params[:comment_id])
    end
end
