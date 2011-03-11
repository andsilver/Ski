Given /^I am signed in as a property developer$/ do
  sign_in_with('bob@myskichalet.co.uk', 'secret')
end

Given /^I am signed in but not as a property developer$/ do
  sign_in_with('alice@myskichalet.co.uk', 'sesame')
end
