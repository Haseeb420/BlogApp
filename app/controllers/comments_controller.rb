class CommentsController < ApplicationController
  before_action :set_post,only:[:new,:create,:reply]
  before_action :build_comment, only:[:reply,:create]
  def index
  end

  def reply
    respond_to do |format|
      format.html { redirect_to post_path(@post) }
      format.js
    end
  end

  def new
    @comment = @post.comments.new(parent_id: params[:parent_id])
  end

  def show
  end

  def create
    respond_to do |format|
      format.html { redirect_to post_path(@post) }
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body,:parent_id)
  end

  def set_post
    puts params[:post_id]
    @post = Post.find(params[:post_id])
  end

  def build_comment
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    puts @comment
    p @comment
    @comment.save
    @comment
  end
end
