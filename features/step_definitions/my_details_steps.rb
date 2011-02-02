Given /^I am not interested in advertising properties for rent$/ do
  a = alice
  a.interested_in_renting_out_properties = false
  a.save
end

When /^I am interested in advertising properties for rent$/ do
  a = alice
  a.interested_in_renting_out_properties = true
  a.save
end
