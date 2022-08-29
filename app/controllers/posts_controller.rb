class PostsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:show]
  def index
    @posts = Post.all.where("user_id=?", current_user.id)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_param)
    @post.published_date = Date.today.to_s
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
end
