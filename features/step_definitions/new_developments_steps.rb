Given /^I am signed in as a ([^"]*)$/ do |role|
  sign_in_with('alice@myskichalet.co.uk', 'sesame') if role == 'estate agent'
  sign_in_with('bob@myskichalet.co.uk', 'secret') if role == 'property developer'
  sign_in_with('dave@myskichalet.co.uk', 'secret') if role == 'property owner'
end
