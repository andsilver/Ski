Given /^I have no adverts in my basket$/ do
end

Given /^I have adverts in my basket$/ do
  d = DirectoryAdvert.create!(:user_id => users(:alice).id, :category_id => categories(:bars).id, :business_address => '123 av')
  a = Advert.new_for(d)
  a.save!
end

Then /^I should see my adverts$/ do
  Then 'I should see "Alice Properties"'
end

Then /^I should see a drop down box to change advert duration$/ do
  response.should have_selector("#basket option", :content => "1 month")
end

Then /^I should see a remove button$/ do
  response.should have_selector("input", :value => "Remove")
end

Then /^I should see a place order button$/ do
  response.should have_selector("input", :value => "Place Order")
end
