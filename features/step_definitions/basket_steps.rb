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
