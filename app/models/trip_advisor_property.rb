# frozen_string_literal: true

class TripAdvisorProperty < ApplicationRecord
  has_one :property, dependent: :destroy
  belongs_to :trip_advisor_location
  delegate :resort, to: :trip_advisor_location, allow_nil: true
  belongs_to :currency

  validates_numericality_of :review_average, less_than_or_equal_to: 5
  validates_presence_of :currency
  validates_presence_of :resort
  validates_presence_of :starting_price
end
