class Post < ApplicationRecord
  belongs_to :post_category
  has_one_attached :header_img
  belongs_to :user
  has_many :post_likes, dependent: :delete_all
  has_many :reported_posts,dependent: :delete_all
  has_many :comments,dependent: :delete_all

  #scope are defined here
  scope :ordered, ->{ order(:published_date)}
  scope :recents_week_post, -> {where("created_at > ?", Time.now-7.days).order(published_date: :desc)}

  enum status:[:not_approved,:approved]

  after_initialize :set_default_role, :if => :new_record?

  private

  def set_default_role
    self.status ||= :not_approved
  end


end
