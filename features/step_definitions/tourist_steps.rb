Then /^I should see the French, Italian, Austrian and Swiss flags$/ do
  response.should have_selector("li.flag_FR")
  response.should have_selector("li.flag_IT")
  response.should have_selector("li.flag_AU")
  response.should have_selector("li.flag_CH")
end

Given /^there are bars advertised in Chamonix$/ do
  DirectoryAdvert.create!(:category_id => categories(:bars).id, :user_id => users(:alice).id)
end

Then /^I should see a list of bars in Chamonix$/ do
  response.should have_selector("table#directory_adverts")
  response.should have_selector("table#directory_adverts td")
end
