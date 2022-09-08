class PostLikesController < ApplicationController

  before_action :authenticate_user!
  # skip_before_action :authenticate_user!, only: [:show]
  before_action :set_post,except:[:destory]
  def index
    if user_exists?
      PostLike.where("user_id=? and post_id=?",current_user.id,params[:post_id]).first.delete
    else
      @post_like = PostLike.new
      @post_like.post_id = @post.id
      @post_like.user_id = current_user.id
      @post_like.save
    end
    @post
    respond_to do |format|
      # @post = Comment.find(params[:post_id]).likes.count
      format.js
    end
  end


  def destory
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
  def user_exists?
    PostLike.where("user_id=? and post_id=?",current_user.id,params[:post_id]).exists?
  end

end
