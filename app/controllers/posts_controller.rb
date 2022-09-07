class PostsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:show]
  before_action :set_post, except:[:create,:index,:new]
  def index
    # @posts = Post.includes(:comments).where(user_id: current_user.id).limit(10).ordered
    @posts = Post.all.where("user_id=?", current_user.id).ordered
  end

  def show
    # @post = Post.includes(:comments).where(id:params[:id]).first
    @post = Post.includes(:comments).where(id:params[:id]).first
  end

  def new
    @post = Post.new
  end

  def likes
    @post.increse_likes
    respond_to do |format|
      format.js
    end
  end

  def recent
    @posts = Post.recents_week_post
    respond_to do |format|
      format.js
    end
  end

  def create
    @post = Post.new(post_param)
    # @post.published_date = Date.today.to_s
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        flash.now[:notice] = 'Post Created Succesfully'
        format.html { redirect_to post_url(@post) }
        # format.js { render :show }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def post_param
    params.require(:post).permit(:title,:body,:header_img,:post_category_id)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
