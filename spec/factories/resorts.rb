FactoryGirl.define do
  factory :resort do
    name        'Tignes'
    association :country
  end
end
