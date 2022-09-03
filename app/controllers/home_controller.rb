class HomeController < ApplicationController
  def index
    @posts = Post.ordered.page(params[:page]).per(10)
    # @posts = Post.ordered.page(params[:page]).per(5)
    # @posts = Post.all
  end

  def about
    # something
  end
end
