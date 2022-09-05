module UserPersmissions
  extend ActiveSupport::Concern

  def is_admin?
    current_user.user_role == "admin" if !current_user.nil?
  end

  def is_moderator?
    current_user.user_role == "moderator" if !current_user.nil?
  end

end
