FactoryGirl.define do
  factory :trip_advisor_property do
    property_type "MyString"
    bedrooms 1
    beds 1
    sleeps 1
    bathrooms 1
    title "MyString"
    country "MyString"
    city "MyString"
    url "MyString"
    status "MyString"
    review_average "9.99"
    show_pin "MyString"
    lat_long "MyString"
    country_code "MyString"
    postal_code "MyString"
    search_url "MyString"
    can_accept_inquiry "MyString"
    booking_option "MyString"
    min_stay_high "MyString"
    min_stay_low "MyString"
    association :trip_advisor_location
  end
end
