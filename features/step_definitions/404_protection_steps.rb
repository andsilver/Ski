When /^I visit an invisible resort page$/ do
  visit resort_path(resorts(:an_invisible_resort))
end

When /^I visit a visible resort page$/ do
  visit resort_path(resorts(:chamonix))
end

Then /^I should see a 404 page$/ do
  step 'I should see "The page you were looking for doesn\'t exist."'
end

Then /^I should not see a 404 page$/ do
  step 'I should not see "The page you were looking for doesn\'t exist."'
end
