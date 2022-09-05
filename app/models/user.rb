class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum user_role:[:user,:admin,:moderator]
  after_initialize :set_default_role, :if => :new_record?

  private
  def set_default_role
    self.user_role ||= :user
  end
  has_one_attached :profile_img
end
