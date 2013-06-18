class Region < ActiveRecord::Base
  belongs_to :country, inverse_of: :regions
  has_many :resorts, inverse_of: :region, dependent: :nullify
  has_many :holiday_type_brochures, dependent: :delete_all, as: :brochurable

  validates :country_id, presence: true
  validates :name, length: { maximum: 100 }, presence: true, uniqueness: { scope: :country }

  validates :slug, presence: true, uniqueness: true

  def to_param
    slug
  end

  def to_s
    name
  end

  def resort_brochures(holiday_type_id)
    HolidayTypeBrochure
      .where(holiday_type_id: holiday_type_id, brochurable_type: 'Resort')
      .joins('INNER JOIN resorts ON resorts.id = holiday_type_brochures.brochurable_id')
      .where(resorts: { region_id: id })
      .order('resorts.name ASC')
  end
end
