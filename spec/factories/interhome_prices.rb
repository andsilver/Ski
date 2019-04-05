FactoryBot.define do
  factory :interhome_price do
    accommodation_code { "A" }
    days { 1 }
    start_date { Date.today }
    end_date { Date.today }
    rental_price { 123 }
    min_rental_price { 100 }
    max_rental_price { 200 }
  end
end
