class Resort < ActiveRecord::Base
  include RelatedPages

  belongs_to :country

  has_many :properties, dependent: :nullify
  has_many :order_lines
  has_many :airport_distances, -> { order 'distance_km ASC' }, dependent: :delete_all
  has_many :airport_transfers, dependent: :delete_all

  has_many :interhome_place_resorts, dependent: :delete_all
  has_many :pv_place_resorts, dependent: :delete_all

  scope :featured, -> { where('featured = 1').order('name') }
  scope :visible, -> { where('visible = 1').order('name') }

  validates_presence_of :name
  validates_uniqueness_of :name, scope: :country_id

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def area_type
    local_area? ? I18n.t('resorts_controller.detail.local_area') : I18n.t('resorts_controller.detail.whole_area')
  end

  def page_title(page_name)
    key = 'resorts_controller.titles.' + page_name.gsub('-', '_')
    title = I18n.t(key, resort: name, default: page_name)
  end

  def self.page_names
    ['how-to-get-there', 'summer-holidays']
  end

  def nearest_airport
    airport_distances.any? ? airport_distances.first.airport : nil
  end

  def to_s
    name
  end
end
