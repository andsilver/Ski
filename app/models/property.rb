# frozen_string_literal: true

class Property < ActiveRecord::Base
  include AdvertBehaviours

  belongs_to :user
  belongs_to :country, optional: true
  belongs_to :region, optional: true
  belongs_to :resort, touch: true
  belongs_to :image, optional: true
  belongs_to :currency

  belongs_to :interhome_accommodation, optional: true
  belongs_to :trip_advisor_property, optional: true

  has_many :images, dependent: :destroy

  # Delete adverts in basket but leave others remaining
  has_many :adverts_in_basket, -> { where starts_at: nil }, class_name: "Advert", dependent: :delete_all
  has_many :adverts, dependent: :nullify

  has_and_belongs_to_many :amenities
  has_many :availabilities, dependent: :delete_all
  has_many :reviews, dependent: :delete_all

  validates_presence_of :resort
  validates_presence_of :address

  validates_presence_of :currency
  validates :price_description, length: {maximum: 30}

  MIN_NAME_LENGTH = 4
  MAX_NAME_LENGTH = 255
  validates_length_of :name, within: MIN_NAME_LENGTH..MAX_NAME_LENGTH
  validates_length_of :strapline, within: 0..255

  VALID_DISTANCES = [0, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1001]

  validates_inclusion_of :distance_from_town_centre_m, in: VALID_DISTANCES

  validates_uniqueness_of :pericles_id, allow_nil: true, scope: :user_id

  validates_inclusion_of :layout, in: LAYOUTS = [nil, "Classic", "Showcase"]
  before_validation :set_empty_layout_to_nil

  before_validation :adjust_distances_if_needed
  before_save :set_country_and_region, :geocode, :normalise_prices, :properties_for_rent_cannot_be_new_developments

  delegate :theme, to: :resort

  cattr_reader :per_page
  @@per_page = 10

  # Use in single-threaded batch imports with #stop_geocoding and
  # #resume_geocoding.
  @@perform_geocode = PERFORM_GEOCODE

  # Use to stop and resume geocoding on a per-Property level such as when
  # doing a multi-process or multi-threaded batch import.
  attr_accessor :perform_geocode

  LISTING_TYPE_FOR_RENT = 0
  LISTING_TYPE_FOR_SALE = 1

  validates :listing_type, inclusion: {in: (LISTING_TYPE_FOR_RENT..LISTING_TYPE_FOR_SALE)}

  ACCOMMODATION_TYPE_CHALET = 0
  ACCOMMODATION_TYPE_APARTMENT = 1
  ACCOMMODATION_TYPE_VILLA = 2
  ACCOMMODATION_TYPE_HOUSE = 3

  ACCOMMODATION_TYPES = (ACCOMMODATION_TYPE_CHALET..ACCOMMODATION_TYPE_HOUSE)

  validates :accommodation_type, inclusion: {in: ACCOMMODATION_TYPES}

  PARKING_NO = 0
  PARKING_ON_STREET = 1
  PARKING_OFF_STREET = 2
  PARKING_GARAGE = 3

  def initialize(params = {})
    super(params)
    @perform_geocode = PERFORM_GEOCODE
  end

  # Returns an internationalised description of the given parking attribute's
  # value.
  #
  # :call-seq:
  #   Property.parking_description(parking_param) -> string
  def self.parking_description parking_param
    {
      PARKING_NO => I18n.t("properties.features.no_parking"),
      PARKING_ON_STREET => I18n.t("properties.features.on_street_parking"),
      PARKING_OFF_STREET => I18n.t("properties.features.off_street_parking"),
      PARKING_GARAGE => I18n.t("properties.features.garage"),
    }[parking_param]
  end

  # Returns an internationalised description of this property's parking
  # attribute.
  #
  # :call-seq:
  #   parking_description -> string
  def parking_description
    Property.parking_description parking
  end

  TV_NO = 0
  TV_YES = 1
  TV_FREEVIEW = 2
  TV_SATELLITE = 3

  def self.tv_description tv_param
    {
      TV_NO => I18n.t("properties.features.no_tv"),
      TV_YES => I18n.t("properties.features.tv"),
      TV_FREEVIEW => I18n.t("properties.features.freeview"),
      TV_SATELLITE => I18n.t("properties.features.cable_or_satellite"),
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
      BOARD_BASIS_SELF_CATERING => I18n.t("properties.features.self_catering"),
      BOARD_BASIS_BED_AND_BREAKFAST => I18n.t("properties.features.bed_and_breakfast"),
      BOARD_BASIS_HALF_BOARD => I18n.t("properties.features.half_board"),
      BOARD_BASIS_FULL_BOARD => I18n.t("properties.features.full_board"),
    }[board_basis_param]
  end

  def board_basis_description
    Property.board_basis_description board_basis
  end

  # Loads each currency and updates its associated properties' normalised
  # prices with direct SQL.
  def self.normalise_prices
    Currency.all.each do |c|
      sql = "UPDATE properties SET normalised_sale_price = sale_price * #{c.in_euros}, normalised_weekly_rent_price = weekly_rent_price * #{c.in_euros} WHERE currency_id = #{c.id}"
      ActiveRecord::Base.connection.update_sql(sql)
    end
  end

  # Returns +true+ if the property's location will be geocoded upon saving.
  def self.geocoding?
    @@perform_geocode && @perform_geocode
  end

  def self.stop_geocoding
    @@perform_geocode = false
  end

  def self.resume_geocoding
    @@perform_geocode = PERFORM_GEOCODE
  end

  # Returns an array of attributes that can be imported by simple assignment
  # from another source, such as a CSV or XML file.
  #
  # :call-seq:
  #   Property.importable_attributes -> array
  def self.importable_attributes
    %w[address balcony cave children_welcome currency_id description
       disabled floor_area_metres_2 for_sale fully_equipped_kitchen garden
       hot_tub images indoor_swimming_pool log_fire long_term_lets_available
       mountain_views name new_development
       number_of_bathrooms number_of_bedrooms outdoor_swimming_pool parking
       pets plot_size_metres_2 postcode resort_id sale_price sauna short_stays
       ski_in_ski_out sleeping_capacity smoking strapline tv weekly_rent_price
       wifi]
  end

  # Returns 15 randomly chosen visible properties. Not fast.
  def self.featured
    Property.order("RAND()").limit(15).where(publicly_visible: true)
  end

  def to_param
    # TODO: Fix LOD violation.
    "#{id}-#{name.parameterize}-#{resort.try(:name).try(:parameterize)}-#{resort.try(:country).try(:name).try(:parameterize)}"
  end

  def for_rent?
    listing_type == LISTING_TYPE_FOR_RENT
  end

  def for_sale?
    listing_type == LISTING_TYPE_FOR_SALE
  end

  def price(advert, property_number)
    pp = PropertyPricer.new(months: advert.months, property_number: property_number)
    pp.price_in_cents
  end

  def has_amenity?(amenity_name)
    amenities.where(name: amenity_name).any?
  end

  # Snaps distances (from town centre) to the closest VALID_DISTANCE.
  def adjust_distances_if_needed
    self.distance_from_town_centre_m = closest_distance(distance_from_town_centre_m)
  end

  def set_empty_layout_to_nil
    self.layout = nil if layout == ""
  end

  def closest_distance d
    VALID_DISTANCES.min { |a, b| (a - d).abs <=> (b - d).abs }
  end

  def geocode
    return unless Property.geocoding?
    self.latitude = ""
    self.longitude = ""
    attempt_geocode(address + "," + postcode + "," + resort.name)
  end

  def attempt_geocode a
    q = CGI.escape("#{a},#{resort.country.name}")
    Rails.logger.info("attempting geocode: #{q}")
    url = "/maps/api/geocode/json?address=#{q}&sensor=false"
    require "net/http"
    http = Net::HTTP.new("maps.googleapis.com", 80)
    response = http.get(url)
    data = response.body
    Rails.logger.info(data)
    begin
      json = JSON.parse(data)
    rescue
      Rails.logger.warn "Error parsing JSON response in Property#attempt_geocode"
      return
    end
    Rails.logger.info json.inspect
    if json["status"] == "OK"
      self.latitude = json["results"][0]["geometry"]["location"]["lat"]
      self.longitude = json["results"][0]["geometry"]["location"]["lng"]
    else
      Rails.logger.info "geocode for #{a} failed; url=#{url}; data=#{data}"
    end
  end

  def normalise_prices
    self.normalised_sale_price = sale_price * currency.in_euros
    self.normalised_weekly_rent_price = weekly_rent_price * currency.in_euros
    nil # don't fail before_save callback
  end

  def properties_for_rent_cannot_be_new_developments
    self.new_development = false if for_rent?
    nil # don't fail before_save callback
  end

  def valid_months
    PropertyBasePrice.order("number_of_months").all.collect {|pbp| pbp.number_of_months}
  end

  # Calculates late availability depending on the best availability
  # information for the property. Returns true if all the dates for which
  # there is availability information are believed to be available.
  #
  # :call-seq:
  #   calculate_late_availability(array_of_dates) -> boolean
  def calculate_late_availability(dates_to_consider)
    interhome_accommodation ? interhome_accommodation.available_to_check_in_on_dates?(dates_to_consider) : !for_sale?
  end

  def cache_availability(dates)
    availabilities.delete_all
    [interhome_accommodation, trip_advisor_property].each do |prop|
      prop.try(:cache_availability, dates)
    end
  end

  # Returns the default number of months that a property advert should be
  # advertised for, depending on its attributes.
  #
  # This is used as a sensible default for adding an advert to the basket.
  # For example, an advertiser of a property for sale will want a shorter
  # duration advert than an advertiser of a property rental.
  #
  # :call-seq:
  #   default_months -> int
  def default_months
    for_sale? ? 3 : 12
  end

  include ActionView::Helpers::TextHelper

  # Truncates the property name and the strapline to 255 characters.
  # If the strapline is blank then the first 255 characters
  # of the description are used as the strapline.
  #
  # HTML is not escaped, ensuring that the lengths do not exceed these
  # limits.
  def tidy_name_and_strapline
    self.strapline = if strapline.blank?
      description.blank? ? "" : truncate(description, escape: false, length: 255, separator: " ")
    else
      truncate(strapline, escape: false, length: 255, separator: " ")
    end
    self.name = name[0...255]
  end

  def set_country_and_region
    self.country = resort.country
    self.region = resort.region
  end

  def basket_advert_type_description
    "Property"
  end

  def template
    tpl = if layout
      layout.downcase.tr(" ", "_")
    elsif new_development?
      "showcase"
    elsif trip_advisor_property
      "trip_advisor"
    else
      "classic"
    end
    "show_#{tpl}"
  end

  def to_s
    name
  end
end
