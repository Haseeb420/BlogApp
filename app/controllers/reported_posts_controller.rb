class ReportedPostsController < ApplicationController
  before_action :set_post, only: %i[new create]
  before_action :build_post_report, only: [:create]
  def index; end

  def new; end

  def create
    respond_to do |format|
      format.js
    end
    respond_to do |format|
      # @comment = Comment.find(params[:comment_id]).likes.count
      format.js
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
    @report.user = current_user
    @report.save
    @report
  end
end
