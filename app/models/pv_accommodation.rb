class PvAccommodation < ActiveRecord::Base
  attr_accessible :accroche_fiche, :accroche_liste, :address_1, :address_2, :code, :description, :iso_3166_1, :iso_3166_2, :latitude, :longitude, :name, :onu, :permalink, :photos, :postcode, :price_table_url, :services, :sports, :town

  has_one :property, dependent: :destroy

  def place_code
    "#{iso_3166_1}-#{iso_3166_2}-#{onu}"
  end

  def showing?
    property && property.currently_advertised?
  end

  def photo_array
    safe_split_str(photos)
  end

  def service_array
    safe_split_str(services)
  end

  private

  def safe_split_str(str)
    str.respond_to?(:split) ? str.split(',') : []
  end
end
