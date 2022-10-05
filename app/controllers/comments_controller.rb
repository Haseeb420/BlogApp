# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_post_by_post_id, only: %i[new create reply destroy]
  before_action :build_comment, only: %i[reply create]
  before_action :delete_comments_post, only: [:destroy]
  def index; end

  def reply
    @comment.user = current_user
    @comment.save
    respond_to do |format|
      format.html { redirect_to post_path(@post) }
      format.js
    end
  end

  def new
    @comment = @post.comments.build(parent_id: params[:parent_id])
  end

  def show; end

  def create
    @comment.user = current_user
    if @comment.save
      respond_to do |format|
        format.html { redirect_to post_path(@post) }
        format.js
      end
    else
      flash.now[:alert] = 'Comment not added Succesfully'
      render new, status: :unprocessable_entity
    end
  end

  def destroy; end

  private
    def comment_params
      params.require(:comment).permit(:body, :parent_id)
    end

    def build_comment
      @comment = @post.comments.build(comment_params)
    end

    def delete_comments_post
      @comment = @post.comments.find(params[:id])
      @comment.destroy
    end
end
