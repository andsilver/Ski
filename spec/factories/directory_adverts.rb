FactoryBot.define do
  factory :directory_advert do
    business_name    { "Business Ltd" }
    business_address { "123 Street" }
    strapline        { "We are awesome" }
    association :resort
    association :user
    association :category
  end
end
