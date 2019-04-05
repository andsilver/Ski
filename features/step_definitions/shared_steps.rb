def alice
  @alice ||= User.find_by(first_name: "Alice")
end

def emily
  @emily ||= User.find_by(first_name: "Emily")
end

def sign_in_with(email, password)
  step "I am on the sign in page"
  fill_in("Email", with: email)
  fill_in("Password", with: password)
  click_button("Sign In")
end

Given /^I am signed in$/ do
  sign_in_with("alice@mychaletfinder.com", "sesame")
end

Given /^I am not signed in$/ do
end

Then /^I should see the "([^"]*)" heading$/ do |arg1|
  page.should have_selector("h1", text: arg1)
end

Then /^I should see a link to "([^"]*)"$/ do |arg1|
  page.should have_selector("a", text: arg1)
end
