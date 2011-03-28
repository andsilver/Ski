class Property < ActiveRecord::Base
  belongs_to :user
  belongs_to :resort
  belongs_to :image

  has_many :adverts

  validates_presence_of :resort_id
  validates_associated :resort

  validates_length_of :name, :within => 5..30
  validates_length_of :strapline, :within => 0..60

  cattr_reader :per_page
  @@per_page = 10

  def to_param
    "#{id}-#{PermalinkFu.escape(name)}-#{PermalinkFu.escape(resort.name)}-#{PermalinkFu.escape(resort.country.name)}"
  end

  def price(advert, property_number)
    pp = PropertyPricer.new(:months => advert.months, :property_number => property_number)
    pp.price_in_cents
  end

  def features
    f = []
    f << "Pets allowed" if pets?
    f << "Smoking allowed" if smoking?
    f << "TV" if tv?
    f << "WiFi" if wifi?
    f << "Suitable for disabled people" if disabled?
    f << "Fully equipped kitchen" if fully_equipped_kitchen?
    f << "Parking" if parking?
    f.inject() { |r,e| r + ", " + e }
  end
end
