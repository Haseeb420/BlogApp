class HomeController < ApplicationController
  before_action :set_posts
  def index
    redirect_to controller: 'moderators', action: 'index' if !current_user.nil? && current_user.moderator?
  end

  def about
    # something
  end

  private

  def set_posts
    @posts = Post.includes(:comments).where(status: 'approved').ordered.page(params[:page]).per(10)
  end
end
