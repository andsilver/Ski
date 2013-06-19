class HolidayType < ActiveRecord::Base
  validates :name, presence: :true, uniqueness: true
  validates :slug, presence: :true, uniqueness: true

  has_many :holiday_type_brochures, dependent: :delete_all

  def country_brochures
    holiday_type_brochures.where(brochurable_type: 'Country')
  end

  def visible_country_brochures
    holiday_type_brochures
      .where(brochurable_type: 'Country')
      .joins('INNER JOIN countries ON countries.id = brochurable_id AND countries.id IN (SELECT DISTINCT(country_id) FROM resorts WHERE visible = 1)')
      .order('countries.name')
  end

  def to_param
    slug
  end

  def to_s
    name
  end
end
