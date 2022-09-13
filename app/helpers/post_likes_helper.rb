# frozen_string_literal: true

module PostLikesHelper
  def post_like_color(id)
    if PostLike.where(user_id:id).exists?
      "text-primary"
    else
      "text-secondary"
    end
  end
end
