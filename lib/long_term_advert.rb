# frozen_string_literal: true

class LongTermAdvert
  attr_reader :advert

  def initialize(property)
    @advert = Advert.new
    @advert.user = property.user
    @advert.property = property
    @advert.starts_at = Time.current
    @advert.expires_at = Time.current + 10.years
    @advert.months = 120
  end

  def create
    @advert.save
  end
end
