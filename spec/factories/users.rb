FactoryGirl.define do
  factory :user do
    first_name           'Zach'
    last_name            'Anyman'
    sequence(:email) { |n| "zach.anyman#{n}@example.org" }
    password             'secret'
    billing_street       '123 Street'
    billing_city         'London'
    description          ''
    terms_and_conditions true
    association :billing_country, factory: :country
    association :role
  end
end
