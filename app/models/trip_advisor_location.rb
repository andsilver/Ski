# frozen_string_literal: true

class TripAdvisorLocation < ApplicationRecord
  # Validations
  validates_presence_of :name
  validates_presence_of :location_type

  # Associations
  has_many :trip_advisor_properties, dependent: :nullify
  belongs_to :resort

  acts_as_tree order: 'name'
end
