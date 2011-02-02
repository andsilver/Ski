Given /^that I am logged in$/ do
  @current_user = User.create!(:name => 'Alice', :email => 'alice@myskichalet.co.uk')

  Given "I am on the login page"
  fill_in("Email", :with => @current_user.email)
  click_button('Login')
end

Given /^that I am not logged in$/ do
end
