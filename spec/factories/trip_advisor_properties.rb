FactoryBot.define do
  factory :trip_advisor_property do
    property_type { "MyString" }
    bedrooms { 1 }
    beds { 1 }
    sleeps { 1 }
    bathrooms { 1 }
    title { "MyString" }
    country { "MyString" }
    city { "MyString" }
    url { "MyString" }
    status { "MyString" }
    review_average { "5.0" }
    show_pin { "MyString" }
    lat_long { "MyString" }
    country_code { "MyString" }
    postal_code { "MyString" }
    search_url { "MyString" }
    can_accept_inquiry { "MyString" }
    booking_option { "MyString" }
    min_stay_high { 6 }
    min_stay_low { 2 }
    association :trip_advisor_location
    starting_price { 123 }
    association :currency
  end
end
