FactoryBot.define do
  factory :interhome_accommodation do
    accommodation_type { "T" }
    bathrooms          { 1 }
    bedrooms           { 2 }
    brand              { 1 }
    details            { "Details" }
    floor              { 100 }
    geodata_lat        { "0" }
    geodata_lng        { "0" }
    name               { "Interhome Accommodation" }
    pax                { 1 }
    place              { "1234" }
    quality            { 3 }
    region             { "1" }
    rooms              { 3 }
    sqm                { 100 }
    themes             { "ABC" }
    toilets            { 1 }
    zip                { "ZIP" }
    sequence(:code)      { |n| "IH-#{n}" }
    sequence(:permalink) { |n| "IH-#{n}" }
    association :country
  end
end
