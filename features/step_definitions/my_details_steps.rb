Given /^I am not interested in advertising properties for rent$/ do
  alice.interested_in_renting_out_properties = false
  alice.save
end

When /^I am interested in advertising properties for rent$/ do
  alice.interested_in_renting_out_properties = true
  alice.save
end
