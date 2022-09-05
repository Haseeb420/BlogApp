class HomeController < ApplicationController

  def index
    if current_user.nil?
      @posts = Post.all
      @posts = Post.ordered.page(params[:page]).per(10)
    else
      if is_moderator?
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
