class ModeratorsController < ApplicationController
  before_action :authenticate_user!
  layout 'moderator_dashboard'

  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index
  before_action :set_posts, only: %i[index recent_post]
  def index
    @dashboard = policy_scope(ModeratorsController)
    flash.now[:alert] = 'You dont have access to that page'
    redirect_to root_path
  end

  def recent_post
    if current_user.moderator?

    else
      flash.now[:alert] = 'You dont have access to that page'
      redirect_to root_path
    end
  end

  def approved_post
    if current_user.moderator?
      @post = Post.find(params[:post_id])
      @post.status = 'approved'
      @post.save
      respond_to do |format|
        format.js
      end
    else
      flash.now[:alert] = 'You dont have access to that page'
      redirect_to root_path
    end
  end

  def reported_post
    @reports = ReportedPost.all.order(created_at: :desc)
  end

  private

  def set_posts
    @posts = Post.recents_week_post
  end
end
