# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :set_posts
  skip_before_action :authenticate_user!
  before_action :redirect_user_dashaboard
  def index; end
  def about; end

  private
    def set_posts
      @posts = Post.all_posts.ordered.page(params[:page]).per(10)
    end

    def redirect_user_dashaboard
      if !current_user.nil? && current_user.moderator?
        redirect_to controller: 'moderators',
                    action: 'index'
      end
      redirect_to '/admin' if !current_user.nil? && current_user.admin?
    end
end
