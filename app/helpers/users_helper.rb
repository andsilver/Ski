module UsersHelper
  def user_action(path, title, description)
    content_tag(:li, "<a href=\"#{path}\" title=\"#{description}\">#{title}</a>".html_safe)
  end
end
