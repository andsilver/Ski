class AirportDistance < ActiveRecord::Base
  belongs_to :resort
  belongs_to :airport

  validates_presence_of :resort_id, :airport_id, :distance_km
end
