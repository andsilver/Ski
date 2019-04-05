FactoryBot.define do
  factory :property do
    sequence(:name) { |n| "Property #{n}" }
    address           { "123 Street" }
    publicly_visible  { true }
    association       :resort
    association       :currency
    association       :user
  end
end
