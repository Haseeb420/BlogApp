class Post < ApplicationRecord
  belongs_to :post_category
  has_one_attached :header_img
  belongs_to :user
  has_many :comments,dependent: :delete_all
  has_many :post_likes, dependent: :delete_all



  validates :title, presence: true

  validates :title,:body,:header_img,presence:true


  #scope are defined here
  scope :ordered, ->{ order(:published_date)}
end
