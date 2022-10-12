# frozen_string_literal: true

class HomeController < ApplicationController
  # before_action :set_posts
  include PostsHelper
  skip_before_action :authenticate_user!
  # skip_before_action :verify_authenticity_token
  before_action :redirect_user_dashaboard
  def index
    respond_to do |format|
      format.json do
        @posts = Post.all_posts.ordered
        @posts = @posts.map { |post| post.as_json.merge({ header_img: post.header_img.service_url,user_name:authur_name_by_id(post.user_id) }) }
        render json: @posts
      end
      format.html do
        @posts = Post.all_posts.ordered.page(params[:page]).per(10)
      end
    end
  end
  def about; end

  private
    def set_posts
      @posts = Post.all_posts.ordered
    end

    def redirect_user_dashaboard
      if !current_user.nil? && current_user.moderator?
        redirect_to controller: 'moderators',
                    action: 'index'
      end
      redirect_to '/admin' if !current_user.nil? && current_user.admin?
    end
end
