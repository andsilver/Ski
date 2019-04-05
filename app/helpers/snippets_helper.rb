# frozen_string_literal: true

module SnippetsHelper
  # Returns the snippet whose name is +name+, or +default+ if no matching
  # snippet is found.
  def snippet(name, default = "")
    s = Snippet.find_by(name: name, locale: @lang)
    s ? s.snippet.html_safe : default.html_safe
  end
end
