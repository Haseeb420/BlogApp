class HomeController < ApplicationController
  def index
    @posts = Post.all
  end

  def about
    # something
  end
end
