class InterhomePlace < ActiveRecord::Base
  validates_uniqueness_of :code, case_sensitive: false

  # Returns a matching Interhome subplace, place, or nil, in that order.
  # Interhome accommodation specifies a 'place' code which can be either a
  # subplace or place.
  def self.find_by_country_and_region_and_place(country, region, place)
    subplace_code = "#{country}_#{region}_XXXX_#{place}"
    place_code = "#{country}_#{region}_#{place}"
    find_by(code: subplace_code) || find_by(code: place_code)
  end
end
