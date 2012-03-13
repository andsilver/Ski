class Property < ActiveRecord::Base
  include AdvertBehaviours

  belongs_to :user
  belongs_to :resort
  belongs_to :image
  belongs_to :currency

  has_many :images, :dependent => :destroy
  has_many :adverts, :dependent => :nullify

  validates_presence_of :resort_id
  validates :resort, :presence => true
  validates_presence_of :address

  validates_length_of :name, :within => 5..50
  validates_length_of :strapline, :within => 0..255

  VALID_DISTANCES = [0, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1001]

  validates_inclusion_of :distance_from_town_centre_m, :in => VALID_DISTANCES
  validates_inclusion_of :metres_from_lift,            :in => VALID_DISTANCES

  validates_inclusion_of :star_rating, :in => 1..5, :message => "is not in the range 1-5"

  validates_uniqueness_of :pericles_id, :allow_nil => true, :scope => :user_id

  before_validation :adjust_distances_if_needed
  before_save :geocode, :normalise_prices, :properties_for_rent_cannot_be_new_developments

  cattr_reader :per_page
  @@per_page = 10
  @@perform_geocode = PERFORM_GEOCODE

  ACCOMMODATION_TYPE_CHALET = 0
  ACCOMMODATION_TYPE_APARTMENT = 1

  def self.accommodation_type_description accommodation_type_param
    {
      ACCOMMODATION_TYPE_CHALET => 'Chalet',
      ACCOMMODATION_TYPE_APARTMENT => 'Apartment'
    }[accommodation_type_param]
  end

  def accommodation_type_description
    Property.accommodation_type_description accommodation_type
  end

  PARKING_NO = 0
  PARKING_ON_STREET = 1
  PARKING_OFF_STREET = 2
  PARKING_GARAGE = 3

  def self.parking_description parking_param
    {
      PARKING_NO => I18n.t('properties.features.no_parking'),
      PARKING_ON_STREET => I18n.t('properties.features.on_street_parking'),
      PARKING_OFF_STREET => I18n.t('properties.features.off_street_parking'),
      PARKING_GARAGE => I18n.t('properties.features.garage')
    }[parking_param]
  end

  def parking_description
    Property.parking_description parking
  end

  TV_NO = 0
  TV_YES = 1
  TV_FREEVIEW = 2
  TV_SATELLITE = 3

  def self.tv_description tv_param
    {
      TV_NO => I18n.t('properties.features.no_tv'),
      TV_YES => I18n.t('properties.features.tv'),
      TV_FREEVIEW => I18n.t('properties.features.freeview'),
      TV_SATELLITE => I18n.t('properties.features.cable_or_satellite')
    }[tv_param]
  end

  def tv_description
    Property.tv_description tv
  end

  BOARD_BASIS_SELF_CATERING = 0
  BOARD_BASIS_BED_AND_BREAKFAST = 1
  BOARD_BASIS_HALF_BOARD = 2
  BOARD_BASIS_FULL_BOARD = 3

  def self.board_basis_description board_basis_param
    {
      BOARD_BASIS_SELF_CATERING => I18n.t('properties.features.self_catering'),
      BOARD_BASIS_BED_AND_BREAKFAST => I18n.t('properties.features.bed_and_breakfast'),
      BOARD_BASIS_HALF_BOARD => I18n.t('properties.features.half_board'),
      BOARD_BASIS_FULL_BOARD => I18n.t('properties.features.full_board')
    }[board_basis_param]
  end

  def board_basis_description
    Property.board_basis_description board_basis
  end

  def self.normalise_prices
    @@perform_geocode = false
    Property.all.each do |p|
      p.save
    end
    @@perform_geocode = PERFORM_GEOCODE
    nil # don't fail before_save callback
  end

  def self.importable_attributes
    %w(address balcony cave children_welcome currency_id description
      disabled floor_area_metres_2 for_sale fully_equipped_kitchen garden
      hot_tub images indoor_swimming_pool log_fire long_term_lets_available
      metres_from_lift mountain_views name new_development
      number_of_bathrooms number_of_bedrooms outdoor_swimming_pool parking
      pets plot_size_metres_2 postcode resort_id sale_price sauna short_stays
      ski_in_ski_out sleeping_capacity smoking strapline tv weekly_rent_price
      wifi)
  end

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
    bedrooms = "#{I18n.t('bedrooms')}: #{number_of_bedrooms}"
    bedrooms += " (#{I18n.t('sleeps')} #{sleeping_capacity})" if for_rent?
    f << board_basis_description if for_rent?
    f << bedrooms
    f << "#{I18n.t('nearest_lift')}: #{metres_from_lift}m" unless metres_from_lift == 0
    f << I18n.t('properties.features.pets') if pets? && for_rent?
    f << I18n.t('properties.features.smoking') if smoking? && for_rent?
    f << tv_description if for_rent?
    f << I18n.t('properties.features.wifi') if wifi? && for_rent?
    f << I18n.t('properties.features.disabled') if disabled?
    f << I18n.t('properties.features.fully_equipped_kitchen') if fully_equipped_kitchen?
    f << I18n.t('properties.features.cave') if cave?
    f << I18n.t('properties.features.garden') if garden?
    f << I18n.t('properties.features.indoor_swimming_pool') if indoor_swimming_pool?
    f << I18n.t('properties.features.outdoor_swimming_pool') if outdoor_swimming_pool?
    f << I18n.t('properties.features.sauna') if sauna?
    f << I18n.t('properties.features.hot_tub') if hot_tub?
    f << I18n.t('properties.filters.ski_in_ski_out') if ski_in_ski_out?
    f << I18n.t('properties.filters.long_term_lets_available') if long_term_lets_available?
    f << parking_description
    f
  end

  def adjust_distances_if_needed
    self.distance_from_town_centre_m = closest_distance(distance_from_town_centre_m)
    self.metres_from_lift = closest_distance(metres_from_lift)
  end

  def closest_distance d
    VALID_DISTANCES.min { |a,b| (a-d).abs <=> (b-d).abs }
  end

  def geocode
    self.latitude = ''
    self.longitude = ''
    attempt_geocode(address + ',' + postcode + ',' + resort.name) if @@perform_geocode
  end

  def attempt_geocode a
    a = "#{a},#{resort.country.name}".gsub("\n", ' ').gsub(' ', '+')
    Rails.logger.info('attempting geocode: ' + a)
    url = '/maps/api/geocode/json?address=' + a + '&sensor=false'
    require 'net/http'
    http = Net::HTTP.new('maps.googleapis.com', 80)
    response, data = http.get(url)
    begin
      json = JSON.parse(data)
    rescue
      Rails.logger.warn "Error parsing JSON response in Property#attempt_geocode"
      return
    end
    Rails.logger.info json.inspect
    if 'OK' == json['status']
      self.latitude = json['results'][0]['geometry']['location']['lat']
      self.longitude = json['results'][0]['geometry']['location']['lng']
    else
      Rails.logger.info "geocode for #{a} failed; url=#{url}; data=#{data}"
    end
  end

  def normalise_prices
    self.normalised_sale_price = sale_price * currency.in_euros
    self.normalised_weekly_rent_price = weekly_rent_price * currency.in_euros
  end

  def properties_for_rent_cannot_be_new_developments
    self.new_development = false if for_rent?
    nil # don't fail before_save callback
  end

  def valid_months
    PropertyBasePrice.order('number_of_months').all.collect {|pbp| pbp.number_of_months}
  end

  def default_months
    for_sale? ? 3 : 12
  end

  # Truncates the property name to 50 characters and the strapline to 255
  # characters. If the strapline is blank then the first 255 characters
  # of the description are used as the strapline.
  def tidy_name_and_strapline
    if strapline.blank?
      self.strapline = description.blank? ? '' : description[0..254]
    else
      self.strapline = strapline[0..254]
    end
    self.name = name[0..49]
  end

  def basket_advert_type_description
    'Property'
  end

  def to_s
    name
  end
end
