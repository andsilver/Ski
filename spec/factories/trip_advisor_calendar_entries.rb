# frozen_string_literal: true

FactoryBot.define do
  factory :trip_advisor_calendar_entry do
    association(:trip_advisor_property)
    status { "BOOKED" }
    inclusive_start { "2017-10-20" }
    exclusive_end { "2017-10-21" }
  end
end
