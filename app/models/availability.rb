class Availability < ActiveRecord::Base
  AVAILABILITIES = [
    UNAVAILABLE = 0,
    AVAILABLE = 1,
    ENQUIRE = 2
  ]

  validates_inclusion_of :availability, in: AVAILABILITIES
end
