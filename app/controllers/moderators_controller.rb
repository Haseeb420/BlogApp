class ModeratorsController < ApplicationController
  before_action :authenticate_user!
  layout 'moderator_dashboard'

  before_action :set_posts, only:[:index,:recent_post]
  def index
    if current_user.moderator?
    else
      flash.now[:alert]="You dont have access to that page"
      redirect_to root_path
    end
  end

  def recent_post
    if current_user.moderator?

    else
      flash.now[:alert]="You dont have access to that page"
      redirect_to root_path
    end
  end

  def approved_post
    if current_user.moderator?
      @post = Post.find(params[:post_id])
      @post.status = "approved"
      @post.save
      respond_to do |format|
        format.js
      end
    else
      flash.now[:alert]="You dont have access to that page"
      redirect_to root_path
    end
  end

  private

  def set_posts
    @posts = Post.recents_week_post
  end
end
