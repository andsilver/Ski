FactoryGirl.define do
  factory :currency do
    sequence(:code) { |n| "AB#{n}" }
  end
end
