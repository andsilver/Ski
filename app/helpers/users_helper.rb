module UsersHelper
  def user_action(path, title, description)
    "<p><a class=\"btn\" rel=\"popover\" href=\"#{path}\" data-original-title=\"#{title}\" data-content=\"#{description}\">#{title}</a></p>".html_safe
  end
end
