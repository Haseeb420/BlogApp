# frozen_string_literal: true

class PostLikesController < ApplicationController
  before_action :authenticate_user!
  # skip_before_action :authenticate_user!, only: [:show]
  before_action :set_post, except: [:destory]
  # after_action :verify_authorized, except: :index
  # after_action :verify_policy_scoped, only: :index

  def show
    if user_exists?
      delete_post_like
    else
      add_like
    end

    respond_to do |format|
      # @post = Comment.find(params[:post_id]).likes.count
      format.js { render "home/index.js.erb" }
    end
  end

  def destory; end

  private
    def set_post
      @post = Post.find(params[:post_id])
    end

    def user_exists?
      PostLike.where("user_id=? and post_id=?", current_user.id, params[:post_id]).exists?
    end

    def add_like
      @post_like = PostLike.new
      @post_like.post_id = @post.id
      @post_like.user_id = current_user.id
      @post_like.save
    end

    def delete_post_like
      PostLike.where("user_id=? and post_id=?", current_user.id, params[:post_id]).first.delete
    end
end
