FactoryBot.define do
  factory :role do
    sequence(:name) { |n| "General advertiser #{n}" }
    admin                          { false }
    select_on_signup               { true }
    advertises_generally           { true }
    advertises_properties_for_rent { false }
    advertises_properties_for_sale { false }
    flag_new_development           { false }
    advertises_through_windows     { false }
  end

  factory :property_developer, class: Role do
    sequence(:name) { |n| "Property developer #{n}" }
    admin                          { false }
    select_on_signup               { true }
    advertises_generally           { true }
    advertises_properties_for_rent { false }
    advertises_properties_for_sale { true }
    flag_new_development           { true }
    advertises_through_windows     { true }
  end

  factory :admin_role, class: Role do
    sequence(:name) { |n| "Admin #{n}" }
    admin                          { true }
    select_on_signup               { false }
    advertises_generally           { false }
    advertises_properties_for_rent { false }
    advertises_properties_for_sale { false }
    flag_new_development           { false }
    advertises_through_windows     { false }
  end
end
