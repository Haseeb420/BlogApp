module UserPersmissions
  extend ActiveSupport::Concern

  def is_admin?
    current_user.user_role == "admin"
  end

  def is_moderator?
    current_user.user_role == "moderator"
  end

end
