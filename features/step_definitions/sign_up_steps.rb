Then /^I have a new account set up$/ do
  carol = User.find_by(email: "carol@mychaletfinder.com")
  carol.should_not be_nil
end
