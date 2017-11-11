FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "category.name#{n}" }
  end
end
