FactoryBot.define do
  factory :airport do
    sequence(:name) { |n| "Airport #{n}" }
    sequence(:code) { |n| "#{n}" }
    association :country
  end
end
