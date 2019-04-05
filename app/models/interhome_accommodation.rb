class InterhomeAccommodation < ActiveRecord::Base
  has_many :interhome_pictures, dependent: :delete_all
  has_one :property, dependent: :destroy

  has_one :interhome_vacancy, dependent: :delete
  delegate :availability_on, to: :interhome_vacancy
  delegate :check_in_on?, to: :interhome_vacancy
  delegate :check_out_on?, to: :interhome_vacancy

  def interhome_place
    InterhomePlace.find_by_country_and_region_and_place(country, region, place)
  end

  def inside_description
    desc = InterhomeInsideDescription.find_by(accommodation_code: code)
    desc ? desc.description : ""
  end

  def outside_description
    desc = InterhomeOutsideDescription.find_by(accommodation_code: code)
    desc ? desc.description : ""
  end

  def partner_link
    "http://www.interhome.co.uk/Forward.aspx?navigationid=10&partnerid=GB1010781&aCode=#{code}"
  end

  # Returns the rental price for today's date. If there are no prices for
  # today then returns the earliest price in the table. If no prices are
  # found then nil is returned.
  def current_price
    prices = InterhomePrice.where(accommodation_code: code).order("start_date")
    prices.each {|p| return p.rental_price if p.start_date <= Date.today && p.end_date >= Date.today}
    prices.first ? prices.first.rental_price : nil
  end

  def available_to_check_in_on_dates?(dates)
    interhome_vacancy ? interhome_vacancy.available_to_check_in_on_dates?(dates) : false
  end

  # Returns an array of features.
  #
  #   a = InterhomeAccommodation.new(features: 'shower,bbq')
  #   a.feature_list # => ["shower", "bbq"]
  def feature_list
    features.try(:split, ",") || []
  end

  def cache_availability(dates)
    return unless interhome_vacancy

    dates.each do |date|
      Availability.create!(
        property_id: property.id,
        start_date: date,
        check_in: check_in_on?(date),
        check_out: check_out_on?(date),
        availability: Availability.availability_from_interhome(availability_on(date)) || Availability::UNAVAILABLE
      )
    end
  end
end
