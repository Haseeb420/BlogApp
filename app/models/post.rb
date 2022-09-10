class Post < ApplicationRecord
  belongs_to :post_category
  has_one_attached :header_img
  belongs_to :user
  has_many :post_likes, dependent: :destroy
  has_many :reported_posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  # scope are defined here
  scope :ordered, -> { order(:published_date) }
  scope :recents_week_post, -> { where('created_at > ?', Time.zone.now - 7.days).order(published_date: :desc) }

  enum status: { not_approved: 0, approved: 1 }

  after_initialize :set_default_role, if: :new_record?

  private

  def set_default_role
    self.status ||= :not_approved
  end
end
