class Country < ActiveRecord::Base
  require File.expand_path('../../../lib/ruby_19', __FILE__)
  has_many :resorts, :order => 'name'
  has_many :visible_resorts, :class_name => 'Resort', :conditions => 'visible = 1'
  has_many :orders
  has_many :order_lines, :include => :order
  has_many :users, :foreign_key => 'billing_country_id'

  scope :with_resorts, where('id IN (SELECT DISTINCT(country_id) FROM resorts)').order('name')
  scope :with_visible_resorts, where('id IN (SELECT DISTINCT(country_id) FROM resorts WHERE visible=1)').order('name')

  validates_uniqueness_of :name
  validates_uniqueness_of :iso_3166_1_alpha_2

  def to_s
    name
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
    paid_order_lines.keep_if {|ol| ol.advert.property && !ol.advert.property.for_sale?}
  end

  def sales_order_lines
    paid_order_lines.keep_if {|ol| ol.advert.property && ol.advert.property.for_sale?}
  end
end
