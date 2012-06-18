class AirportDistance < ActiveRecord::Base
  attr_accessible :airport_id, :distance_km, :resort_id

  belongs_to :resort
  belongs_to :airport

  validates_presence_of :resort_id, :airport_id, :distance_km
end
