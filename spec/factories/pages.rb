FactoryGirl.define do
  factory :page do
    sequence(:path) { |n| "path-#{n}" }
  end
end
