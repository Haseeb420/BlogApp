class CommentLikesController < ApplicationController
  before_action :authenticate_user!
  # skip_before_action :authenticate_user!, only: [:show]
  before_action :set_comment,except:[:destory]
  def index
    if user_exists?
      CommentLike.where("user_id=? and comment_id=?",current_user.id,params[:comment_id]).first.delete
    else
      @comment_like = CommentLike.new
      @comment_like.comment_id = @comment.id
      @comment_like.user_id = current_user.id
      @comment_like.save
    end
    @comment
    respond_to do |format|
      # @comment = Comment.find(params[:comment_id]).likes.count
      format.js
    end
  end


  def destory
  end

  private

  def set_comment
    @comment = Comment.find(params[:comment_id])
  end
  def user_exists?
    CommentLike.where("user_id=? and comment_id=?",current_user.id,params[:comment_id]).exists?
  end


end
