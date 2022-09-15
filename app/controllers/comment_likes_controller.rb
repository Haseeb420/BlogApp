# frozen_string_literal: true

class CommentLikesController < ApplicationController
  before_action :set_comment, except: [:destory]
  before_action :build_comment_like
  before_action :get_comment_like_instance


  def index
    if @comment_like_instance.user_exists?(current_user.id, @comment.id)
      @comment_like_instance.delete_user_comment_like(current_user.id, @comment.id)
    else
      @comment_like.comment_id = @comment.id
      @comment_like.user_id = current_user.id
      @comment_like.save
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

    def build_comment_like
      @comment_like = @comment.comment_likes.build
      # @comment_like = CommentLike.new
    end

    def get_comment_like_instance
      if @comment_like_instance.nil?
        @comment_like_instance = CommentLike.new
      end
      @comment_like_instance
    end
end
