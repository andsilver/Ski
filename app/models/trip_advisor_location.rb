class TripAdvisorLocation < ApplicationRecord
  # Validations
  validates_presence_of :name
  validates_presence_of :location_type
end
