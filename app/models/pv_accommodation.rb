class PvAccommodation < ActiveRecord::Base
  attr_accessible :accroche_fiche, :accroche_liste, :address_1, :address_2, :code, :description, :iso_3166_1, :iso_3166_2, :latitude, :longitude, :name, :onu, :permalink, :postcode, :price_table_url, :services, :sports, :town

  has_one :property, dependent: :destroy

  def place_code
    "#{iso_3166_1}-#{iso_3166_2}-#{onu}"
  end

  def showing?
    property && property.currently_advertised?
  end
end
