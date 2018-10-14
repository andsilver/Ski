FactoryBot.define do
  factory :airport_distance do
    association :resort
    association :airport
    distance_km { 50 }
  end
end
