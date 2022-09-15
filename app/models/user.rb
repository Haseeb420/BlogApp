# frozen_string_literal: true

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
  validates :profile_img, presence: true, blob: { content_type: ["image/png", "image/jpg", "image/jpeg"],
                                                  size_range: 1..(5.megabytes) }

  validates :user_role, inclusion: { in: %w[admin user moderator],
                                     message: "%<value>s is not a valid status" }

  scope :recents_week_users, -> { where("created_at > ?", Time.zone.now - 7.days) }

  enum user_role: { user: 0, admin: 1, moderator: 2 }

  after_initialize :set_default_role, if: :new_record?

  def user_all_post
    posts
  end

  private
    def set_default_role
      self.user_role ||= :user
    end
end
