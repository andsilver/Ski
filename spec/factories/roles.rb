FactoryGirl.define do
  factory :role do
    name                           'General advertiser'
    admin                          false
    select_on_signup               true
    advertises_generally           true
    advertises_properties_for_rent false
    advertises_properties_for_sale false
    flag_new_development           false
    advertises_through_windows     false
  end
end
