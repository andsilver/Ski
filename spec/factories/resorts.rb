FactoryBot.define do
  factory :resort do
    sequence(:name) { |n| "Resort #{n}" }
    association :country
    sequence(:slug) { |n| "resort-#{n}" }
    visible { true }
  end
end
