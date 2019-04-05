FactoryBot.define do
  factory :trip_advisor_location do
    association :resort
    name { "MyString" }
    location_type { "MyString" }
    parent_id { nil }
  end
end
