class TripAdvisorLocation < ApplicationRecord
  # Validations
  validates_presence_of :name
  validates_presence_of :location_type

  # Associations
  has_many :trip_advisor_properties, dependent: :nullify

  acts_as_tree order: 'name'
end
