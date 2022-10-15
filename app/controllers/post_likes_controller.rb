# frozen_string_literal: true

class PostLikesController < ApplicationController
  before_action :authenticate_user!
  # skip_before_action :authenticate_user!, only: [:show]
  before_action :set_post, except: [:destory]

  def show
    if @post.user_post_like_exists?(current_user.id)
      @post.delete_user_post_like current_user.id
    else
      @post.add_post_like(current_user.id)
    end

    respond_to do |format|
      # @post = Comment.find(params[:post_id]).likes.count
      format.js { render 'home/index.js.erb' }
    end
  end

  def destory; end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
