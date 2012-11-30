class Resort < ActiveRecord::Base
  attr_accessible :altitude_m, :apres_ski, :babysitting_services, :beginner,
    :black, :blue, :cable_car, :chair, :country_id, :creche,
    :cross_country_km, :drags, :expert, :family, :feature, :featured, :funicular,
    :gallery_content, :glacier_skiing, :gondola, :green, :heli_skiing,
    :image_id, :info, :insider_view, :intermediate,
    :introduction, :living_in, :local_area, :longest_run_km,
    :mountain_restaurants, :name, :off_piste, :owning_a_property_in,
    :piste_map_content, :railways, :red, :season, :ski_area_km,
    :slope_direction, :snowboard_parks, :summer_holidays_in, :summer_skiing,
    :top_lift_m, :weather_code, :visible, :visiting

  belongs_to :country
  belongs_to :image, dependent: :destroy

  has_many :properties, dependent: :nullify
  has_many :order_lines
  has_many :airport_distances, dependent: :delete_all, order: 'distance_km ASC'
  has_many :airport_transfers, dependent: :delete_all
  has_many :interhome_place_resorts, dependent: :delete_all

  scope :featured, where('featured = 1').order('name')
  scope :visible, where('visible = 1').order('name')

  validates_presence_of :name
  validates_uniqueness_of :name, scope: :country_id

  after_save :handle_name_change
  before_destroy :destroy_pages

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def area_type
    local_area? ? I18n.t('resorts_controller.detail.local_area') : I18n.t('resorts_controller.detail.whole_area')
  end

  def has_page?(page_name)
    !page(page_name).nil?
  end

  def page(page_name)
    Page.find_by_path(page_path(page_name))
  end

  def create_page(page_name)
    Page.create(path: page_path(page_name), title: page_name)
  end

  def page_path(page_name)
    "/resorts/#{to_param}/#{page_name}"
  end

  def destroy_pages
    Resort.page_names.each {|n| page.destroy if has_page?(n)}
  end

  def self.page_names
    ['how-to-get-there']
  end

  def handle_name_change
    if name_changed?
      Resort.page_names.each do |page_name|
        p = Page.find_by_path("/resorts/#{id}-#{name_was.parameterize}/#{page_name}")
        if p
          p.path = page_path(page_name)
          p.save
        end
      end
    end
  end

  def to_s
    name
  end
end
