# frozen_string_literal: true

FactoryBot.define do
  factory :amenity do
    sequence(:name) { |n| "AMENITY#{n}" }
  end
end
