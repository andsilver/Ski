module ViewSpecHelpers
  def rendered
    # Using @rendered variable, which is set by the render-method.
    Capybara.string(@rendered)
  end

  def within(selector)
    yield rendered.find(selector)
  end
end
