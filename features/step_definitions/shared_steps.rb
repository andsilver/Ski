def alice
  User.find_by_name('Alice')
end

Given /^that I am signed in$/ do
  @current_user = User.create!(:name => 'Alice', :email => 'alice@myskichalet.co.uk', :password => 'sesame')

  Given "I am on the sign in page"
  fill_in("Email", :with => @current_user.email)
  fill_in("Password", :with => @current_user.password)
  click_button('Sign In')
end

Given /^that I am not signed in$/ do
end

Then /^I should see the "([^"]*)" heading$/ do |arg1|
  response.should have_selector("h1", :content => arg1)
end
