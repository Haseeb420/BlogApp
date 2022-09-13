# frozen_string_literal: true

class ModeratorsController < ApplicationController
  layout 'moderator_dashboard'
  before_action :user_not_authorized
  before_action :set_posts, only: %i[index recent_post]
  def index; end

  def recent_post; end

  def approved_post
    if current_user.moderator?
      @post = Post.find(params[:post_id])
      @post.status = 'approved'
      @post.save
      respond_to do |format|
        format.js
      end
    else
      flash.now[:alert] = 'You dont have access to that page'
      redirect_to root_path
    end
  end

  def suggestions
    @suggestions = Suggestion.all.order(created_at: :desc)
  end

  def delete_suggestions
    Suggestion.delete(params[:id])
    # respond_to do |format|
    #   format.js {render "delete_suggestions.js.erb"}
    # end
    redirect_to action: 'suggestions'
  end

  def reported_post
    @reports = ReportedPost.all.order(created_at: :desc)
  end

  def post_details
    @post = Post.find(params[:post_id])
  end

  private

  def set_posts
    @posts = Post.recents_week_post
  end

  def user_not_authorized
    unless current_user.moderator?
      flash[:alert] = 'You are not authorized to perform this action.'
      redirect_to(request.referer || root_path)
    end
  end
end
