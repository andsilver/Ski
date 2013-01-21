class BannerPrice < ActiveRecord::Base
  attr_accessible :current_banner_number, :price

  validates_uniqueness_of :current_banner_number
  validates_uniqueness_of :price

  def self.price_for_advert_number(n)
    price = nil

    BannerPrice.order(:current_banner_number).all.each do |bp|
      price = bp.price if n >= bp.current_banner_number
    end

    raise 'No valid banner price' if price.nil?

    price
  end
end
