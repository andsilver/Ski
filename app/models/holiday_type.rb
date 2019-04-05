# frozen_string_literal: true

class HolidayType < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true

  has_many :holiday_type_brochures, dependent: :delete_all

  scope :on_menu, -> { where(visible_on_menu: true) }

  def country_brochures
    holiday_type_brochures.where(brochurable_type: "Country")
  end

  def visible_country_brochures
    holiday_type_brochures
      .where(brochurable_type: "Country")
      .joins(
        "INNER JOIN countries ON countries.id = brochurable_id " \
        "AND countries.id IN " \
        "(SELECT DISTINCT(country_id) FROM resorts WHERE visible = 1)"
      )
      .order("countries.name")
  end

  def to_param
    slug
  end

  def to_s
    name
  end

  def featured_properties(how_many)
    Property.order(Arel.sql("RAND()"))
      .limit(how_many)
      .where(
        [
          "resort_id IN (SELECT brochurable_id FROM " \
          "holiday_type_brochures WHERE holiday_type_id = ? " \
          'AND brochurable_type = "Resort")',
          id,
        ]
      )
  end
end
