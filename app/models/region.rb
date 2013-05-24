class Region < ActiveRecord::Base
  belongs_to :country, inverse_of: :regions
  has_many :resorts, inverse_of: :region, dependent: :nullify

  validates :country_id, presence: true
  validates :name, length: { maximum: 100 }, presence: true, uniqueness: { scope: :country }

  def to_s; name; end
end
