Then /^I have a new account set up$/ do
  carol = User.find_by_email('carol@myskichalet.co.uk')
  carol.should_not be_nil
end
