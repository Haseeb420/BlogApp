class HomeController < ApplicationController

  def index
    if is_moderator?
      redirect_to controller:"moderators", action: "index"
    end
    redirect_to controller:"moderators", action: "index"

  end

  def about
    # something
  end

  private



end
