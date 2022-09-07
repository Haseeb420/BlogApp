class HomeController < ApplicationController

  def index
    if current_user.nil?
      @posts = Post.includes(:comments).page(params[:page]).per(10)
    else
      if current_user.moderator?
        redirect_to controller:"moderators", action: "index"
      else
        @posts = Post.all
        @posts = Post.ordered.page(params[:page]).per(10)
      end
    end
  end

  def about
    # something
  end

  private

end
