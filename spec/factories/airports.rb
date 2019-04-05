FactoryBot.define do
  factory :airport do
    sequence(:name) { |n| "Airport #{n}" }
    sequence(:code) { |n| n.to_s }
    association :country
  end
end
