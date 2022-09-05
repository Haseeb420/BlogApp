module CommentsHelper
  def commenter_name(commenter_id)
    if current_user and commenter_id == current_user.id
      "You"
    else
      user = User.find(commenter_id)
      "#{user.first_name} #{user.last_name}"
    end
  end
end
