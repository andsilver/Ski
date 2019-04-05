FactoryBot.define do
  factory :page do
    title { "Title" }
    sequence(:path) { |n| "path-#{n}" }
  end
end
