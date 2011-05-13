class Country < ActiveRecord::Base
  has_many :resorts, :order => 'name'
  has_many :visible_resorts, :class_name => 'Resort', :conditions => 'visible = 1'
  has_many :orders
  has_many :order_lines
  has_many :users, :foreign_key => 'billing_country_id'

  scope :with_resorts, where('id IN (SELECT DISTINCT(country_id) FROM resorts)').order('name')
  scope :with_visible_resorts, where('id IN (SELECT DISTINCT(country_id) FROM resorts WHERE visible=1)').order('name')

  validates_uniqueness_of :name
  validates_uniqueness_of :iso_3166_1_alpha_2

  def to_s
    name
  end
end
