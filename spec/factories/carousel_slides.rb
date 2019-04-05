# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :carousel_slide do
    caption   { "Caption" }
    image_url { "#" }
    link      { "#" }
  end
end
