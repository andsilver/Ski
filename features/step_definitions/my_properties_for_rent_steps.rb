When /^I have no properties for rent$/ do
end

When /^I have properties for rent$/ do
  properties = Property.create([
    {:user_id => alice.id, :title => 'Catered Chalet in Chamonix, Sleeps 4, with Cave', :metres_from_lift => 1000, :sleeps => 4},
    {:user_id => alice.id, :title => 'Chalet Maya, Luxury, Sleeps 8', :metres_from_lift => 800, :sleeps => 8}
    ])
end
