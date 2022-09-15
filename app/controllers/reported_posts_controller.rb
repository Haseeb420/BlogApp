# frozen_string_literal: true

class ReportedPostsController < ApplicationController
  before_action :set_post, only: %i[new create]
  before_action :build_post_report, only: [:create]
  def index; end

  def new; end

  def create
    @report.user = current_user
    if @report.save
      respond_to do |format|
        format.js { render "show.js.erb" }
      end
    end
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
