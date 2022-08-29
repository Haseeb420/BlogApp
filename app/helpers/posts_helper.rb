module PostsHelper
  def date_formatter(date)
    date.strftime("%d-%m-%Y") if !date.nil?
  end

  def authur_name_by_id(id)
    user = User.find(id)
    "#{user.first_name} #{user.last_name}"
  end
end
