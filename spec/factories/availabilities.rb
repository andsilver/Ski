# frozen_string_literal: true

FactoryBot.define do
  factory :availability do
    association :property
    availability { Availability::AVAILABLE }
    start_date { Date.current }
    check_in { true }
    check_out { true }
  end
end
