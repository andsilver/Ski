def alice
  @alice ||= User.find_by_name('Alice')
end

def sign_in_with(email, password)
  Given "I am on the sign in page"
  fill_in("Email", :with => email)
  fill_in("Password", :with => password)
  click_button('Sign In')
end

Given /^I am signed in$/ do
  sign_in_with('alice@myskichalet.co.uk', 'sesame')
end

Given /^I am not signed in$/ do
end

Then /^I should see the "([^"]*)" heading$/ do |arg1|
  response.should have_selector("h1", :content => arg1)
end
