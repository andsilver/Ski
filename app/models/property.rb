class Property < ActiveRecord::Base
  belongs_to :user
  belongs_to :resort
  belongs_to :image

  has_many :images, :dependent => :destroy
  has_many :adverts

  validates_presence_of :resort_id
  validates_associated :resort
  validates_presence_of :address

  validates_length_of :name, :within => 5..30
  validates_length_of :strapline, :within => 0..60

  before_save :geocode

  cattr_reader :per_page
  @@per_page = 10

  def to_param
    "#{id}-#{PermalinkFu.escape(name)}-#{PermalinkFu.escape(resort.name)}-#{PermalinkFu.escape(resort.country.name)}"
  end

  def for_rent?
    !for_sale?
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

  def short_description
    if description.nil?
      ""
    else
      wordcount = 25
      description.split[0..(wordcount-1)].join(" ") + (description.split.size > wordcount ? "…" : "")
    end
  end

  def current_advert
    Advert.where("property_id = ? AND expires_at > ?", id, Time.now).first
  end

  def currently_advertised?
    !current_advert.nil?
  end

  def geocode
    self.latitude = ''
    self.longitude = ''
    attempt_geocode(address + ',' + postcode + ',' + resort.name)
  end

  def attempt_geocode a
    a = "#{a},#{resort.country.name}".gsub("\n", ' ').gsub(' ', '+')
    Rails.logger.info('attempting geocode: ' + a)
    url = '/maps/api/geocode/json?address=' + a + '&sensor=false'
    require 'net/http'
    http = Net::HTTP.new('maps.googleapis.com', 80)
    response, data = http.get(url)
    json = JSON.parse(data)
    Rails.logger.info json.inspect
    if 'OK' == json['status']
      self.latitude = json['results'][0]['geometry']['location']['lat']
      self.longitude = json['results'][0]['geometry']['location']['lng']
      true
    else
      Rails.logger.info "geocode for #{a} failed; url=#{url}; data=#{data}"
      false
    end
  end
end
