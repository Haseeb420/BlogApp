class Post < ApplicationRecord
  belongs_to :post_category
  has_one_attached :header_img
  belongs_to :user
  has_many :comments



  validates :title, presence: true

  validates :title,:body,:header_img,presence:true


  #scope are defined here
  scope :ordered, ->{ order(published_date: :desc)}
end
