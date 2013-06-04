class Country < ActiveRecord::Base
  include RelatedPages

  belongs_to :image, dependent: :destroy

  has_many :regions, -> { order 'name' }, inverse_of: :country
  has_many :resorts, -> { order 'name' }
  has_many :visible_resorts, -> { where(visible: true).order('name') }, class_name: 'Resort'
  has_many :orders
  has_many :order_lines, -> { includes :order }
  has_many :users, foreign_key: 'billing_country_id'
  has_one :buying_guide, dependent: :delete

  scope :with_resorts, -> { where('id IN (SELECT DISTINCT(country_id) FROM resorts)').order('name') }
  scope :with_visible_resorts, -> { where('id IN (SELECT DISTINCT(country_id) FROM resorts WHERE visible=1)').order('name') }
  scope :popular_billing_countries, -> { order('popular_billing_country DESC, name ASC') }

  validates_uniqueness_of :name
  validates_uniqueness_of :iso_3166_1_alpha_2

  liquid_methods :name

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def to_s
    name
  end

  def featured_properties(limit)
    Property.order('RAND()').limit(limit).where(country_id: id, publicly_visible: true)
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
    order_lines.select {|ol| ol.order.payment_received?}
  end

  def rentals_order_lines
    paid_order_lines.keep_if {|ol| ol.advert && ol.advert.property && !ol.advert.property.for_sale?}
  end

  def sales_order_lines
    paid_order_lines.keep_if {|ol| ol.advert && ol.advert.property && ol.advert.property.for_sale?}
  end

  def page_title(page_name)
    key = 'countries_controller.titles.' + page_name.gsub('-', '_')
    title = I18n.t(key, country: name, default: page_name)
  end

  def self.page_names
    HolidayType.all.map { |ht| ht.slug }
  end
end
