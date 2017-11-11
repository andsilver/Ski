FactoryBot.define do
  sequence :name do |n|
    "Country #{n}"
  end

  sequence :iso_3166_1_alpha_2 do |n|
    "CODE#{n}"
  end

  factory :country do
    name
    iso_3166_1_alpha_2
    sequence(:slug) { |n| "country-#{n}" }
  end
end
