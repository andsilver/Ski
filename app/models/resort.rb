class Resort < ActiveRecord::Base
  include Brochures
  include RelatedPages

  belongs_to :country
  belongs_to :region, inverse_of: :resorts

  has_many :directory_adverts, dependent: :restrict_with_exception
  has_many :properties, dependent: :restrict_with_exception
  has_many :order_lines
  has_many :airport_distances, -> { order 'distance_km ASC' }, dependent: :delete_all
  has_many :airport_transfers, dependent: :delete_all

  has_many :interhome_place_resorts, dependent: :delete_all
  has_many :pv_place_resorts, dependent: :delete_all

  scope :featured, -> { where('featured = 1').order('name') }
  scope :visible, -> { where('visible = 1').order('name') }

  validates_presence_of :name
  validates_uniqueness_of :name, scope: :country_id

  validates :slug, ModelConstants::FLAT_NAMESPACE_SLUG_VALIDATIONS

  def to_param
    slug
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

  def ski?
    holiday_types.any? { |ht| ht.slug == 'ski-holidays' }
  end

  def to_s
    name
  end
end
