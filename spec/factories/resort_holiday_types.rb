# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :resort_holiday_type do
    resort_id { 1 }
    holiday_type_id { 1 }
  end
end
