class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:confirmable


  # all relations are starts here
  has_one_attached :profile_img
  has_many :posts
  has_many :comments
  has_one :post_like
  has_one :comment_like
  #all relations are ends here

end
