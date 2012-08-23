class InterhomeAccommodation < ActiveRecord::Base
  has_many :interhome_pictures, dependent: :delete_all
  has_one :property, dependent: :destroy
  has_one :interhome_vacancy, dependent: :delete

  def inside_description
    desc = InterhomeInsideDescription.find_by_accommodation_code(code)
    desc ? desc.description : ''
  end

  def outside_description
    desc = InterhomeOutsideDescription.find_by_accommodation_code(code)
    desc ? desc.description : ''
  end

  def partner_link
    "http://www.interhome.co.uk/Forward.aspx?navigationid=10&partnerid=CH1000651&aCode=#{code}"
  end

  # Returns the rental price for today's date. If there are no prices for
  # today then returns the earliest price in the table. If no prices are
  # found then nil is returned.
  def current_price
    prices = InterhomePrice.where(accommodation_code: code).order('start_date')
    prices.each {|p| return p.rental_price if p.start_date <= Date.today && p.end_date >= Date.today}
    prices.first ? prices.first.rental_price : nil
  end
end
