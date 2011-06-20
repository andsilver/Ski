class Airport < ActiveRecord::Base
  belongs_to :country
  has_many :resorts

  validates_presence_of :name
  validates_presence_of :code
  validates_presence_of :country_id

  validates_uniqueness_of :code
end
