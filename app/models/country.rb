class Country < ActiveRecord::Base
  has_many :resorts, :order => 'name'

  scope :with_resorts, where('id IN (SELECT DISTINCT(country_id) FROM resorts)')

  validates_uniqueness_of :name
  validates_uniqueness_of :iso_3166_1_alpha_2

  def to_s
    name
  end
end
