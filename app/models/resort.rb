class Resort < ActiveRecord::Base
  belongs_to :country
  belongs_to :image, :dependent => :destroy

  has_many :properties, :dependent => :nullify
  has_many :order_lines
  has_many :airport_distances, :dependent => :delete_all, :order => 'distance_km ASC'
  has_many :interhome_place_resorts, :dependent => :delete_all

  scope :featured, where('featured = 1').order('name')
  scope :visible, where('visible = 1').order('name')

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :country_id

  def to_param
    "#{id}-#{PermalinkFu.escape(name)}"
  end

  def area_type
    local_area? ? I18n.t('resorts_controller.detail.local_area') : I18n.t('resorts_controller.detail.whole_area')
  end

  def to_s
    name
  end
end
