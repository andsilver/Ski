def alice
  @alice ||= User.find_by_name('Alice')
end

Given /^I am signed in$/ do
  @current_user = User.create!(
    :name => 'Alice',
    :email => 'alice@myskichalet.co.uk',
    :password => 'sesame',
    :description => '',
    :billing_street => '1 Main Avenue',
    :billing_city => 'Winchester',
    :billing_country_id => 5,
    :terms_and_conditions => true
    )

  Given "I am on the sign in page"
  fill_in("Email", :with => @current_user.email)
  fill_in("Password", :with => @current_user.password)
  click_button('Sign In')
end

Given /^I am not signed in$/ do
end

Then /^I should see the "([^"]*)" heading$/ do |arg1|
  response.should have_selector("h1", :content => arg1)
end
