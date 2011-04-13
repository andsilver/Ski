Given /^there are bars advertised in Chamonix$/ do
  DirectoryAdvert.create!(:category_id => categories(:bars).id, :user_id => users(:alice).id, :business_address => '123 av')
end

Then /^I should see a list of bars in Chamonix$/ do
  response.should have_selector("table#directory_adverts")
  response.should have_selector("table#directory_adverts td")
end

Then /^I should see weekly rent prices$/ do
  Then 'I should see "€1,200"'
end

Then /^I should see sale prices$/ do
  Then 'I should see "€195,000"'
end
