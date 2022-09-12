# frozen_string_literal: true

class PostLikesController < ApplicationController
  before_action :authenticate_user!
  # skip_before_action :authenticate_user!, only: [:show]
  before_action :set_post, except: [:destory]
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def index
    if user_exists?
      PostLike.where('user_id=? and post_id=?', current_user.id, params[:post_id]).first.delete
    else
      @post_like = PostLike.new
      @post_like.post_id = @post.id
      @post_like.user_id = current_user.id
      @post_like.save
    end

    @post
    @post_like = policy_scope(PostLike)
    respond_to do |format|
      # @post = Comment.find(params[:post_id]).likes.count
      format.js
    end
  end

  def destory; end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def user_exists?
    PostLike.where('user_id=? and post_id=?', current_user.id, params[:post_id]).exists?
  end
end
