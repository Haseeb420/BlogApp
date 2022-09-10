module SetPostConcern
  extend ActiveSupport::Concern

  def set_post_by_post_id
    @post = Post.find(params[:post_id])
  end
end
