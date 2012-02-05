Given /^there are bars advertised in Chamonix$/ do
  da = DirectoryAdvert.create!(
    :category_id => categories(:bars).id,
    :user_id => users(:alice).id,
    :business_address => '123 av',
    :resort_id => resorts(:chamonix).id,
    :business_name => 'Business',
    :strapline => 'Strapline'
  )
  a = Advert.new_for(da)
  a.expires_at = Time.now + 1.day
  a.save
end

Then /^I should see a list of bars in Chamonix$/ do
  page.should have_selector("table#directory_adverts")
  page.should have_selector("table#directory_adverts td")
end

Then /^I should see weekly rent prices$/ do
  Then 'I should see "€1,200"'
end

Then /^I should see sale prices$/ do
  Then 'I should see "€195,000"'
end
