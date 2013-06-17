class Region < ActiveRecord::Base
  belongs_to :country, inverse_of: :regions
  has_many :resorts, inverse_of: :region, dependent: :nullify
  has_many :holiday_type_brochures, dependent: :delete_all, as: :brochurable

  validates :country_id, presence: true
  validates :name, length: { maximum: 100 }, presence: true, uniqueness: { scope: :country }

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def to_s
    name
  end
end
