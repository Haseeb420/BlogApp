class CommentsController < ApplicationController
  def index
  end

  def new
    @post = Post.find(params[:post_id])
    puts params[:parent_id]
    @comment = @post.comments.new(parent_id: params[:parent_id])

  end

  def show
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.commented_on = Date.today.to_s
    @comment.save
    respond_to do |format|
      format.html { redirect_to post_path(@post) }
      format.js
    end

  end

  private

  def comment_params
    params.require(:comment).permit(:body,:parent_id)
  end
end
