FactoryBot.define do
  factory :interhome_vacancy do
    association :interhome_accommodation
    accommodation_code { "CODE" }
  end
end
