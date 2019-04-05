FactoryBot.define do
  factory :a_property_developer, class: User do
    first_name           { "Zach" }
    last_name            { "Anyman" }
    sequence(:email) { |n| "zach.anyman#{n}@example.org" }
    password             { "secret" }
    billing_street       { "123 Street" }
    billing_city         { "London" }
    phone                { "+44.1234 567890" }
    description          { "" }
    terms_and_conditions { true }
    association :billing_country, factory: :country
    association :role, factory: :property_developer
  end

  factory :user do
    first_name           { "Zach" }
    last_name            { "Anyman" }
    sequence(:email) { |n| "zach.anyman#{n}@example.org" }
    password             { "secret" }
    billing_street       { "123 Street" }
    billing_city         { "London" }
    phone                { "+44.1234 567890" }
    description          { "" }
    terms_and_conditions { true }
    association :billing_country, factory: :country
    association :role
  end

  factory :admin_user, class: User do
    first_name           { "Tony" }
    last_name            { "Taccone" }
    sequence(:email) { |n| "tony.taccone#{n}@mychaletfinder.com" }
    password             { "secret" }
    billing_street       { "123 Street" }
    billing_city         { "Edinburgh" }
    phone                { "+44.1234 567890" }
    description          { "" }
    terms_and_conditions { true }
    association :billing_country, factory: :country
    association :role, factory: :admin_role
  end
end
