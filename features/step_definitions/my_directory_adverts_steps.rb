Given /^my business is called "([^"]*)"$/ do |arg1|
  emily.business_name = arg1
  emily.save
end

Given /^I have directory adverts$/ do
  DirectoryAdvert.create!(:user_id => emily.id, :category_id => categories(:bars).id, :business_address => '123 av', :resort_id => 1)
end

Given /^I have no directory adverts$/ do
end
