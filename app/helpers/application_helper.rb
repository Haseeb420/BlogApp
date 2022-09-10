module ApplicationHelper
  def nav_links
    if user_signed_in?
      content_tag(:li, class: 'nav-item') do
        content_tag(:a, 'Logout', href: destroy_user_session_path, data_method: :delete, class: 'nav-link text-danger')
      end
    end
  end
end
