FactoryBot.define do
  factory :banner_price do
    sequence(:current_banner_number) { |n| n }
    sequence(:price) { |n| n }
  end
end
