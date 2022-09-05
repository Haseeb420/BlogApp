class CommentLikesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:show]

  def index
    respond_to do |format|
      # @comment = Comment.find(params[:comment_id]).likes.count
      format.js
    end
  end

  def new
    @comment = Comment.find(params[:comment_id])
  end

  def create
    @comment = Comment.find(params[:comment_id])
  end

  def destory
  end
end
