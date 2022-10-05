# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :post_category
  belongs_to :user
  has_many :post_likes, dependent: :destroy
  has_many :reported_posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :suggestions, dependent: :destroy
  has_one_attached :header_img

  enum status: { not_approved: 0, approved: 1 }

  validates :title, presence: true, length: { minimum: 3, maximum: 200 }
  validates :body, presence: true, length: { minimum: 50 }
  validates :header_img, presence: true, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'],
                                                 size_range: 1..(5.megabytes) }
  validates :status, inclusion: { in: %w[not_approved approved],
                                  message: '%<value> is not a valid status for post' }
  # scope are defined here
  scope :ordered, -> { order(published_date: :desc) }
  scope :recents_week_post, lambda {
                              where('created_at > ?', Time.zone.now - 7.days).order(published_date: :desc)
                            }
  scope :approved_post, -> { where(status: 'approved') }
  scope :all_posts, -> { includes(:comments).approved.order(published_date: :desc) }
  after_initialize :set_default_role, if: :new_record?

  def user_post_like_exists?(user_id)
    post_likes.where(user_id: user_id).exists?
  end

  def delete_user_post_like(user_id)
    post_likes.where(user_id: user_id).first.delete
  end

  def add_post_like(user_id)
    @post_like = post_likes.build
    @post_like.user_id = user_id
    @post_like.save
  end

  private
    def set_default_role
      self.status ||= :not_approved
    end
end
