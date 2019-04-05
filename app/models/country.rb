# frozen_string_literal: true

class Country < ActiveRecord::Base
  include Brochures
  include RelatedPages

  belongs_to :image, dependent: :destroy, optional: true

  has_many :regions, -> { order "name" }, inverse_of: :country, dependent: :destroy
  has_many :visible_regions, -> { where(visible: true).order("name") }, class_name: "Region"
  has_many :resorts, -> { order "name" }
  has_many :visible_resorts, -> { where(visible: true).order("name") }, class_name: "Resort"
  has_many :orders
  has_many :order_lines, -> { includes :order }
  has_many :users, foreign_key: "billing_country_id"
  has_one :buying_guide, dependent: :delete

  scope :with_resorts, -> { where("id IN (SELECT DISTINCT(country_id) FROM resorts)").order("name") }
  scope :with_visible_resorts, -> { where("id IN (SELECT DISTINCT(country_id) FROM resorts WHERE visible=1)").order("name") }
  scope :popular_billing_countries, -> { order("popular_billing_country DESC, name ASC") }

  validates_uniqueness_of :name
  validates_uniqueness_of :iso_3166_1_alpha_2

  validates :slug, presence: true, uniqueness: true

  liquid_methods :name

  def to_param
    slug
  end

  def to_s
    name
  end

  def region_brochures(holiday_type_id)
    child_brochures(holiday_type_id, Region)
  end

  def resort_brochures(holiday_type_id)
    child_brochures(holiday_type_id, Resort)
  end

  # Returns a list of resort brochures for this country. Resorts that belong
  # to regions are excluded.
  def resort_without_region_brochures(holiday_type_id)
    resort_brochures(holiday_type_id).where("resorts" => {region_id: nil})
  end

  def featured_properties(limit)
    Property.order(Arel.sql("RAND()"))
      .limit(limit)
      .where(country_id: id, publicly_visible: true)
  end

  def gross_revenue_rentals_ytd
    total = 0
    rentals_order_lines.each do |ol|
      total += ol.amount unless ol.coupon
    end
    total
  end

  def gross_revenue_sales_ytd
    total = 0
    sales_order_lines.each do |ol|
      total += ol.amount unless ol.coupon
    end
    total
  end

  def count_rentals_ytd
    total = 0
    rentals_order_lines.each do |ol|
      total += 1 unless ol.coupon
    end
    total
  end

  def count_sales_ytd
    total = 0
    sales_order_lines.each do |ol|
      total += 1 unless ol.coupon
    end
    total
  end

  def paid_order_lines
    order_lines.select { |ol| ol.order.payment_received? }
  end

  def rentals_order_lines
    paid_order_lines.keep_if do |ol|
      ol.advert&.property && !ol.advert.property.for_sale?
    end
  end

  def sales_order_lines
    paid_order_lines.keep_if do |ol|
      ol.advert&.property && ol.advert.property.for_sale?
    end
  end

  def page_title(page_name)
    key = "countries_controller.titles." + page_name.tr("-", "_")
    I18n.t(key, country: name, default: page_name)
  end

  def self.page_names
    HolidayType.all.map(&:slug)
  end

  def property_count_for_holiday_type(holiday_type)
    resort_brochures(holiday_type.id).inject(0) do |sum, rb|
      sum + rb.brochurable.property_count
    end
  end

  private

  def child_brochures(holiday_type_id, klass)
    table = klass.to_s.tableize
    HolidayTypeBrochure
      .where(holiday_type_id: holiday_type_id, brochurable_type: klass.to_s)
      .joins(
        "INNER JOIN #{table} " \
        "ON #{table}.id = holiday_type_brochures.brochurable_id"
      )
      .where(table => {country_id: id, visible: true})
      .order("#{table}.name ASC")
  end
end
