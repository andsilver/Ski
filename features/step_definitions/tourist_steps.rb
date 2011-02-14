Then /^I should see the French, Italian, Austrian and Swiss flags$/ do
  response.should have_selector("li#flag_FR")
  response.should have_selector("li#flag_IT")
  response.should have_selector("li#flag_AU")
  response.should have_selector("li#flag_CH")
end
