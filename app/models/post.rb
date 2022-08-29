class Post < ApplicationRecord
  belongs_to :post_category
  has_one_attached :header_img
end
