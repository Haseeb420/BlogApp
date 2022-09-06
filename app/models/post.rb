class Post < ApplicationRecord
  belongs_to :post_category
  has_one_attached :header_img
  belongs_to :user
  has_many :comments
  has_many :reported_posts
  validates :title, presence: true
  validates :title,:body,:header_img,presence:true

  #scope are defined here
  scope :ordered, ->{ order(:published_date)}
  scope :recents_week_post, -> {where("created_at > ?", Time.now-7.days).order(published_date: :desc)}

  enum status:[:not_approved,:approved]

  after_initialize :set_default_role, :if => :new_record?


  def increse_likes
    self.likes = likes + 1
    save
    likes
  end
  private

  def set_default_role
    self.status ||= :not_approved
  end


end
