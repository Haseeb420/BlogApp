# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_post_by_post_id, only: %i[new create reply destroy]
  before_action :build_comment, only: %i[reply create]
  before_action :delete_comments_post, only: [:destroy]
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def index; end

  def reply
    authorize @comment
    respond_to do |format|
      format.html { redirect_to post_path(@post) }
      format.js
    end
  end

  def new
    @comment = @post.comments.new(parent_id: params[:parent_id])
  end

  def show; end

  def create
    authorize @comment
    respond_to do |format|
      format.html { redirect_to post_path(@post) }
      format.js
    end
  end

  def destroy; end

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end

  def build_comment
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    @comment
  end

  def delete_comments_post
    @comments = @post.comments.find(params[:id])
    @comment.destroy
  end
end
