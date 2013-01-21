class Airport < ActiveRecord::Base
  attr_accessible :code, :country_id, :name

  belongs_to :country
  has_many :airport_distances, dependent: :delete_all
  has_many :airport_transfers, dependent: :delete_all

  validates_presence_of :name
  validates_presence_of :code
  validates_presence_of :country_id

  validates_uniqueness_of :code

  def to_s
    name
  end
end
