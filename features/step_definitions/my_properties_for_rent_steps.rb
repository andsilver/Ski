When /^I have no properties for rent$/ do
end

When /^I have properties for rent$/ do
  properties = Property.create!([
    {
      :user_id => alice.id,
      :resort_id => resorts(:chamonix).id,
      :name => 'Chalet Azimuth',
      :address => '74400',
      :strapline => 'Catered Chalet in Chamonix, Sleeps 4, with Cave',
      :metres_from_lift => 1000,
      :distance_from_town_centre_m => 500,
      :sleeping_capacity => 4,
      :currency_id => currencies(:euros).id
    },
    {
      :user_id => alice.id,
      :resort_id => resorts(:chamonix).id,
      :name => 'Chalet Maya',
      :address => '74400',
      :metres_from_lift => 800,
      :distance_from_town_centre_m => 400,
      :sleeping_capacity => 8,
      :currency_id => currencies(:euros).id
    }
  ])
end

Then /^my new property for rent has been saved$/ do
  property = Property.find_by_name('Chalet Des Sapins')
  property.should_not be_nil
end
