Given /^that I am signed in$/ do
  @current_user = User.create!(:name => 'Alice', :email => 'alice@myskichalet.co.uk')

  Given "I am on the sign in page"
  fill_in("Email", :with => @current_user.email)
  click_button('Sign In')
end

Given /^that I am not signed in$/ do
end

Then /^I get redirected$/ do
  follow_redirect!
end
