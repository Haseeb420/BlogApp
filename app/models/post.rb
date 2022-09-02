class Post < ApplicationRecord
  belongs_to :post_category
  has_one_attached :header_img

  def increse_likes
    self.likes = likes + 1
    save
    likes
  end
end
