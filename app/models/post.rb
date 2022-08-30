class Post < ApplicationRecord
  belongs_to :post_category
  has_one_attached :header_img
  has_many :comments
  belongs_to :user
  scope :ordered, ->{ order(published_date: :desc)}

  validates :title, presence: true
  validates :title, length: {minimum:30}
  validates :title,:body,:header_img,presence:true
end
