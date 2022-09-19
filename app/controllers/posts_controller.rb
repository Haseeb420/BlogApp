# frozen_string_literal: true

# app/controllers/post_controller
class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :set_post, except: %i[new create index recent]
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def index
    @post = policy_scope(Post)
    authorize @post
    @posts = current_user.user_all_post
  end

  def show
    authorize @post
  end

  def post_approval
    authorize @post
    @post.status = "approved"
    @post.save
    respond_to do |format|
      format.js { "" }
    end
  end

  def post_detail
    authorize @post
    render layout: "moderator_dashboard"
  end

  def new
    @post = Post.new
    authorize @post
  end

  def recent
    @posts = Post.recents_week_post
    authorize @posts
    respond_to do |format|
      format.html { render layout: "moderator_dashboard" }
      format.js
    end
  end

  def create
    @post = Post.new(post_param)
    @post.user_id = current_user.id

    respond_to do |format|
      authorize @post
      if @post.save
        flash.now[:notice] = "Post Created Succesfully"
        format.html { redirect_to post_url(@post) }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
    authorize @post
  end

  def update
    if @post.update(post_param)
      redirect_to @post
    else
      render "edit"
    end
  end

  def destroy
    authorize @post
    @post.destroy
    redirect_to action: "index"
  end

  private
    def post_param
      params.require(:post).permit(:title, :body, :header_img, :post_category_id)
    end

    def set_post
      @post = Post.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "Post not found"
      redirect_to root_path
    end
end
