class HomeController < ApplicationController

  def index
    if is_admin?
      flash.now[:notice] = "admin"

    end
    flash.now[:notice] = "other user"
  end

  def about
    # something
  end

  private



end
