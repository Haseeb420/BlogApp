# frozen_string_literal: true

# app/controllers/post_controller
class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :post_list]
  before_action :set_post, except: %i[new create index recent post_list]
  after_action :verify_authorized, except: [:index, :post_list]
  after_action :verify_policy_scoped, only: [:index, :post_list]

  def index
    @post = policy_scope(Post)
    authorize @post
    @posts = current_user.user_all_post
  end

  def show
    authorize @post
    respond_to do |format|
      format.json do
        user =  User.find(@post.user_id)
        render json: @post.as_json().merge({header_img: @post.header_img.service_url,user_name:"#{user.first_name} #{user.last_name}".capitalize()})
      end
      format.html
    end
  end

  def new
    @post = Post.new
    authorize @post
  end

  def create
    @post = Post.new(post_param)
    authorize @post
    puts @post.body
    @post.user_id = current_user.id
    respond_to do |format|
      if @post.save
        flash.now[:notice] = 'Post Created Succesfully'
        format.html { redirect_to post_url(@post) }
      else
        flash.now[:alert] = 'Post not Created Succesfully'
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
    authorize @post
  end

  def update
    authorize @post
    if @post.update(post_param)
      flash.now[:notice] = 'Post Updated Succesfully'
      redirect_to @post
    else
      flash.now[:alert] = 'Post not Updated Succesfully'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @post
    if @post.destroy
      redirect_to posts_path
    else
      flash[:alert] = 'Post not deleted'
      redirect_to post_path(@post)
    end
  end

  def post_approval
    authorize @post
    @post.status = 'approved'
    @post.save
    respond_to do |format|
      format.js
    end
  end

  def post_detail
    authorize @post
    render layout: 'moderator_dashboard'
  end

  def recent
    @posts = Post.recents_week_post
    authorize @posts
    respond_to do |format|
      format.html { render layout: 'moderator_dashboard' }
      format.js
    end
  end

  def post_list
    @post = policy_scope(Post)
    authorize @post
    @posts = Post.all_posts.ordered
    render json: @posts
  end

  private
    def post_param
      params.require(:post).permit(:title, :body, :header_img, :post_category_id)
    end

    def set_post
      @post = Post.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = 'Post not found'
      redirect_to root_path
    end
end
