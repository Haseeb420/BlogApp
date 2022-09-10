class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable

  has_one :comment_like, dependent: :delete
  has_many :comments, dependent: :delete_all
  has_one :post_like, dependent: :delete
  has_many :reported_posts, dependent: :delete_all
  has_many :posts, dependent: :delete_all
  has_one_attached :profile_img
  # all relations are ends here

  scope :recents_week_users, -> { where('created_at > ?', Time.zone.now - 7.days) }

  enum user_role: { user: 0, admin: 1, moderator: 2 }
  after_initialize :set_default_role, if: :new_record?

  private

  def set_default_role
    self.user_role ||= :user
  end
end
