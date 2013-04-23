class AirportTransfer < ActiveRecord::Base
  belongs_to :airport
  belongs_to :resort
  belongs_to :user

  validates_presence_of :airport
  validates_presence_of :resort
  validates_presence_of :user
  validates_uniqueness_of :resort_id, scope: [:airport_id, :user_id]
end
