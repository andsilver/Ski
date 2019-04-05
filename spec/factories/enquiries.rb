FactoryBot.define do
  factory :enquiry do
    association :user
    name { "Little Miss Curious" }
    email { "curious@example.com" }
    phone { "01234 567890" }
  end
end
