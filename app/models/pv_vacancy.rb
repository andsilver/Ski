class PvVacancy < ActiveRecord::Base
  attr_accessible :apartment_code, :base_price, :destination_code, :duration, :promo_price_de, :promo_price_en, :promo_price_es, :promo_price_fr, :promo_price_it, :promo_price_nl, :start_date, :stock_quantity, :typology
end
