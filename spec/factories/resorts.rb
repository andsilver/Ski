FactoryGirl.define do
  factory :resort do
    name        'Tignes'
    association :country
    sequence(:slug) { |n| "resort-#{n}" }
    visible     true
  end
end
