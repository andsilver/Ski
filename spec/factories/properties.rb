FactoryGirl.define do
  factory :property do
    name        'My Castle'
    address     '123 Street'
    association :resort
    association :currency
    association :user
  end
end
