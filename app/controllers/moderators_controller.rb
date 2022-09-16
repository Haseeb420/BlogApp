# frozen_string_literal: true

class ModeratorsController < ApplicationController
  layout "moderator_dashboard"
  before_action :user_not_authorized
  before_action :set_posts, only: %i[index]
  def index; end

  def suggestions
    @suggestions = Suggestion.all.order(created_at: :desc)
  end

  def delete_suggestions
    Suggestion.delete(params[:id])
    redirect_to action: "suggestions"
  end

  def reported_post
    @reports = ReportedPost.all.order(created_at: :desc)
  end

  private
    def set_posts
      @posts = Post.recents_week_post
    end

    def user_not_authorized
      unless current_user.moderator?
        flash[:alert] = "You are not authorized to perform this action."
        redirect_to(request.referer || root_path)
      end
    end
end
