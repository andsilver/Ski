FactoryBot.define do
  factory :pv_accommodation do
    address_1       '123 Rue'
    address_2       ''
    iso_3166_1      'FR'
    iso_3166_2      'FR-06'
    latitude        '0'
    longitude       '0'
    name            'PV Accommodation'
    onu             'FR-NCE'
    price_table_url '#'
    postcode        ''
    town            ''
    sequence(:code)      { |n| "PV-#{n}" }
    sequence(:permalink) { |n| "PV-#{n}" }
  end
end
