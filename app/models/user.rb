class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:confirmable

  has_one_attached :profile_img
  has_many :posts,dependent: :destroy
  has_many :comments,dependent: :destroy
  has_one :post_like,dependent: :destroy
  has_one :comment_like,dependent: :destroy
  has_many :reported_posts,dependent: :destroy
  #all relations are ends here

  scope :recents_week_users, ->  {where("created_at > ?", Time.now-7.days)}

  enum user_role: [:user,:admin,:moderator]
  after_initialize :set_default_role, :if => :new_record?

  private

  def set_default_role
    self.user_role ||= :user
  end
end
