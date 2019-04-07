# frozen_string_literal: true

class Region < ActiveRecord::Base
  include Brochures
  include RelatedPages

  belongs_to :country, inverse_of: :regions
  has_many :resorts, -> { order "name" },
    inverse_of: :region, dependent: :nullify
  has_many :airport_distances, through: :resorts

  validates :country, presence: true
  validates :name,
    length: {maximum: 100}, presence: true,
    uniqueness: {scope: :country}

  validates :slug, ModelConstants::FLAT_NAMESPACE_SLUG_VALIDATIONS

  def self.page_names
    ["how-to-get-there"]
  end

  def page_title(page_name)
    key = "regions_controller.titles." + page_name.tr("-", "_")
    I18n.t(key, region: name, default: page_name)
  end

  def visible_resorts
    resorts.where(visible: true)
  end

  def to_param
    slug
  end

  def to_s
    name
  end

  def resort_brochures(holiday_type_id)
    HolidayTypeBrochure
      .where(holiday_type_id: holiday_type_id, brochurable_type: "Resort")
      .joins(
        "INNER JOIN resorts " \
        "ON resorts.id = holiday_type_brochures.brochurable_id"
      )
      .where(resorts: {region_id: id, visible: true})
      .order("resorts.name ASC")
  end

  def featured_properties(limit)
    Property.order(Arel.sql("RAND()"))
      .limit(limit)
      .where(region_id: id, publicly_visible: true)
  end

  # Returns the number of properties for rent within this region.
  def for_rent_count
    resort_sum("for_rent_count")
  end

  # Returns the number of properties for sale within this region.
  def for_sale_count
    resort_sum("for_sale_count")
  end

  # Returns the SUM of +column+ in dependent resorts.
  def resort_sum(column)
    conn = ActiveRecord::Base.connection
    result = conn.execute(
      "SELECT SUM(#{column}) FROM resorts WHERE region_id = #{id}"
    )
    result.first[0]
  end
end
