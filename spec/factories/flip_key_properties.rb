# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :flip_key_property do
    json_data '{"property_details": [{"bedroom_count": ["2"], "bathroom_count": ["1"], "occupancy": ["5"], "property_type": ["Apt. / Condo"]}], "property_descriptions": [{"property_description": [{"description": ["Property description."]}, {}, {"description": ["Location description."]}]}], "property_addresses": [{"city": ["City"], "latitude": ["0"], "longitude": ["0"]}], "property_calendar": [{"booked_date": []}], "property_rates": [{"property_rate": []}], "property_default_rates": [{}], "property_amenities": [{}], "property_rate_summary": [{"day_min_rate": [{}], "week_min_rate": [{}], "month_min_rate": [{}]}]}'
    sequence(:url) { |n| "http://www.flipkey.com/planet-earth-rentals/p#{n}/" }
  end
end
