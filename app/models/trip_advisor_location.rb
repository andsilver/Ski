# frozen_string_literal: true

class TripAdvisorLocation < ApplicationRecord
  # Validations
  validates_presence_of :name
  validates_presence_of :location_type

  # Associations
  has_many :trip_advisor_properties, dependent: :nullify
  belongs_to :resort, optional: true

  acts_as_tree order: "name"

  # Sets the resort ID for this location and all children recursively.
  def cascade_resort_id=(resort_id)
    self.resort_id = resort_id
    save
    children.each {|c| c.cascade_resort_id = resort_id}
  end
end
