# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :set_posts
  skip_before_action :authenticate_user!
  def index
    redirect_to controller: "moderators", action: "index" if !current_user.nil? && current_user.moderator?
  end

  def about; end

  private
    def set_posts
      @posts = Post.all_posts.ordered.page(params[:page]).per(10)
    end
end
