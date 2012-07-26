module SnippetsHelper
  def snippet(name)
    s = Snippet.find_by_name_and_locale(name, @lang)
    s ? s.snippet.html_safe : ''
  end
end
