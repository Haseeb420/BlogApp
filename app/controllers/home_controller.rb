class HomeController < ApplicationController

  def index
    if is_moderator?
      redirect_to controller:"moderators", action: "index"
    end
      @posts = Post.all
      @posts = Post.ordered.page(params[:page]).per(10)
    # @posts = Post.ordered.page(params[:page]).per(5)
    # @posts = Post.all
  end

  def about
    # something
  end

  private

end
