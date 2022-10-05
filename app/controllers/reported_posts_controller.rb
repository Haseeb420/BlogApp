# frozen_string_literal: true

class ReportedPostsController < ApplicationController
  before_action :set_post, only: %i[new create destroy]
  before_action :build_post_report, only: [:create]
  def index
    @reports = ReportedPost.all
    render layout: 'moderator_dashboard'
  end

  def new; end

  def create
    @report.user = current_user
    if @report.save
      respond_to do |format|
        format.js { render 'posts/show.js.erb' }
      end
    end
  end

  def destroy
    @suggestion = @post.reported_posts.find(params[:id])
    @suggestion.destroy
    redirect_to reported_posts_path
  end

  private
    def reported_post_params
      params.require(:reported_post).permit(:reason)
    end

    def set_post
      @post = Post.find(params[:post_id])
    end

    def build_post_report
      @report = @post.reported_posts.build(reported_post_params)
    end
end
