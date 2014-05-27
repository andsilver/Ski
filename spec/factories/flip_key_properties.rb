# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :flip_key_property do
    xml_data "MyText"
    sequence(:url) { |n| "http://www.flipkey.com/planet-earth-retnals/p#{n}/" }
  end
end
