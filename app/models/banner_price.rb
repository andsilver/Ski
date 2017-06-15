class BannerPrice < ActiveRecord::Base
  validates_numericality_of :current_banner_number
  validates_uniqueness_of :current_banner_number
  validates_numericality_of :price
  validates_uniqueness_of :price

  def self.price_for_advert_number(n)
    price = nil

    BannerPrice.order(:current_banner_number).each do |bp|
      price = bp.price if n >= bp.current_banner_number
    end

    raise 'No valid banner price' if price.nil?

    price
  end
end
