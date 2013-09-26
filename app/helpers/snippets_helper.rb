module SnippetsHelper
  def snippet(name)
    s = Snippet.find_by(name: name, locale: @lang)
    s ? s.snippet.html_safe : ''
  end
end
