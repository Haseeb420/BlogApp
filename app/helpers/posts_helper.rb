module PostsHelper
  def date_formatter(date)
    date.strftime("%d-%m-%Y") if !date.nil?
  end

  def authur_name_by_id(id)
    user = User.find(id)
    "#{user.first_name} #{user.last_name}"
  end
  def post_counter_all
    Post.count
  end

  def post_last_week_counter
    Post.recents_week_post.count
  end

  def user_counter_last_week
    User.recents_week_users.count
  end

  def post_status_show(status)
    if status=="approved"
      "Approved"
    else
      "Not Approved"
    end
  end
  def counter_post_reported_last_week
    ReportedPost.count
  end

end
