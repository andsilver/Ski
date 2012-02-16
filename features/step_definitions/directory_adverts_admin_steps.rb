Then /^I should see a list of directory adverts$/ do
  Then 'I should see "Monkey Bar"'
end

When /^I delete Monkey Bar$/ do
  click_button 'Delete'
end

Then /^Monkey Bar should no longer be there$/ do
  Then 'I should not see "Monkey Bar"'
end
