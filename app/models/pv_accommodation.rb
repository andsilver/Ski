class PvAccommodation < ActiveRecord::Base
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
