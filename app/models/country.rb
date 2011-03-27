class Country < ActiveRecord::Base
  has_many :resorts

  scope :with_resorts, where('id IN (SELECT DISTINCT(country_id) FROM resorts)')

  def to_s
    name
  end
end
