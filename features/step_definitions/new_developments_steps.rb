def valid_property attributes
  defaults = {
    user_id: 1,
    resort_id: resorts(:chamonix).id,
    name: "Property",
    address: "74400",
    listing_type: Property::LISTING_TYPE_FOR_SALE,
    distance_from_town_centre_m: 100,
    currency: currencies(:euros),
  }

  Property.new defaults.merge(attributes)
end

Given /^I am signed in as an? ([^"]*)$/ do |role|
  sign_in_with("alice@mychaletfinder.com", "sesame") if role == "estate agent"
  sign_in_with("bob@mychaletfinder.com", "secret") if role == "property developer"
  sign_in_with("dave@mychaletfinder.com", "secret") if role == "property owner"
  sign_in_with("emily@mychaletfinder.com", "secret") if role == "other business"
  sign_in_with("tony@mychaletfinder.com", "secret") if role == "administrator"
end

Given /^there are (\d+) new developments advertised$/ do |how_many|
  how_many.to_i.times do |d|
    # make each new property cheaper than the last
    # as default sort order is "Price low to high"
    p = valid_property name: "New development #{d + 1}",
                       new_development: true, sale_price: (100 - d.to_i), publicly_visible: true
    p.save!
    Advert.create!(user_id: p.user_id, property_id: p.id)
  end
  resorts(:chamonix).new_development_count = how_many
  resorts(:chamonix).save
end

Then /^I should see (\d+) out of (\d+) new developments$/ do |how_many, total|
  last = how_many.to_i
  Range.new(1, last).each do |d|
    step "I should see \"New development #{d}\""
  end
  step "I should not see \"New development #{last + 1}\""
end
