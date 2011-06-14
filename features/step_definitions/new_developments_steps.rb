def valid_property attributes
  defaults = {
    :user_id => 1,
    :resort_id => resorts(:chamonix).id,
    :name => 'Property',
    :address => '74400',
    :for_sale => true
  }

  Property.new defaults.merge(attributes)
end

Given /^I am signed in as an? ([^"]*)$/ do |role|
  sign_in_with('alice@mychaletfinder.com', 'sesame') if role == 'estate agent'
  sign_in_with('bob@mychaletfinder.com', 'secret') if role == 'property developer'
  sign_in_with('dave@mychaletfinder.com', 'secret') if role == 'property owner'
  sign_in_with('emily@mychaletfinder.com', 'secret') if role == 'other business'
  sign_in_with('tony@mychaletfinder.com', 'secret') if role == 'administrator'
end

Given /^there are (\d+) new developments advertised$/ do |how_many|
  how_many.to_i.times do |d|
    # make each new property cheaper than the last
    # as default sort order is "Price low to high"
    p = valid_property :name => "New development #{d}",
      :new_development => true, :sale_price => (100 - d.to_i)
    p.save
    Advert.create(:user_id => p.user_id, :property_id => p.id, :expires_at => Time.now + 1.days)
  end
end

Then /^I should see (\d+) out of (\d+) new developments$/ do |how_many, total|
  first = total.to_i - 1
  last = total.to_i - how_many.to_i
  Range.new(first, last) do |d|
    Then "I should see \"New development #{d}\""
  end
  But "I should not see \"New development #{total.to_i - how_many.to_i - 1}\""
end
