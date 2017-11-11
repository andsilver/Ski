# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :holiday_type do
    sequence(:name) { |n| "Holiday Type #{n}" }
    sequence(:slug) { |n| "holiday-type-#{n}" }
  end
end
