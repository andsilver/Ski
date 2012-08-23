Then /^I should see a summary of my details and an option to edit$/ do
  response.should have_selector("div#my_details_summary")
  response.should have_selector("#my_details_summary #billing_address")
  response.should have_selector("#my_details_summary p", content: "Edit my details")
end
