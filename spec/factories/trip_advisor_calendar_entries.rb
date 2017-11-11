# frozen_string_literal: true

FactoryBot.define do
  factory :trip_advisor_calendar_entry do
    trip_advisor_property_id 1
    status "MyString"
    inclusive_start "2017-10-20"
    exclusive_end "2017-10-21"
  end
end
