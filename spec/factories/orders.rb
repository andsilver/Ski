FactoryBot.define do
  factory :order do
    sequence(:order_number) { |n| n.to_s }
    address     { "123 Street" }
    association :country
    association :user
    association :currency
    email       { "advertiser@example.org" }
    name        { "Alice Advertiser" }
    phone       { "01234 567890" }
    status      { Order::WAITING_FOR_PAYMENT }
    total       { 150.00 }
  end
end
