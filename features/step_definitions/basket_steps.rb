Given /^I have no adverts in my basket$/ do
end

Given /^I have adverts in my basket$/ do
  d = a_directory_advert
  a = Advert.new_for(d)
  a.save!
end

def a_directory_advert(opts = {})
  DirectoryAdvert.create!({
    user_id: users(:alice).id,
    category_id: categories(:bars).id,
    business_name: "Chambre Dix",
    business_address: "123 av",
    resort: resorts(:st_anton),
    strapline: "A favourite meeting place for locals and visitors alike",
  }.merge(opts))
end

Then /^I should see my adverts$/ do
  step 'I should see "Chambre Dix"'
end

Then /^I should see a drop down box to change advert duration$/ do
  page.should have_selector("#basket option", text: "12 months")
end

Then /^I should see a remove button$/ do
  page.should have_selector("input[value='Remove']")
end

Then /^I should see a place order button$/ do
  page.should have_selector("input[value='Place Order']")
end
