def valid_property attributes
  defaults = {
    :user_id => 1,
    :resort_id => 1,
    :name => 'Property'
  }

  Property.new defaults.merge(attributes)
end

Given /^I am signed in as a ([^"]*)$/ do |role|
  sign_in_with('alice@myskichalet.co.uk', 'sesame') if role == 'estate agent'
  sign_in_with('bob@myskichalet.co.uk', 'secret') if role == 'property developer'
  sign_in_with('dave@myskichalet.co.uk', 'secret') if role == 'property owner'
end

Given /^there are (\d+) new developments$/ do |how_many|
  how_many.to_i.times do |d|
    p = valid_property :name => "New development #{d}", :new_development => true
    p.save
  end
end

Then /^I should see (\d+) new developments$/ do |how_many|
  how_many.to_i.times do |d|
    Then "I should see \"New development #{d}\""
  end
  But "I should not see \"New development #{how_many}\""
end
