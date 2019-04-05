Given /^I have directory adverts for a business called "([^"]*)"$/ do |arg1|
  DirectoryAdvert.create!(
    user_id: emily.id,
    category_id: categories(:bars).id,
    business_name: arg1,
    business_address: "123 av",
    resort: resorts(:st_anton),
    strapline: "A favourite meeting place for locals and visitors alike"
  )
end

Given /^I have no directory adverts$/ do
end
