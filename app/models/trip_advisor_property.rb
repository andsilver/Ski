# frozen_string_literal: true

class TripAdvisorProperty < ApplicationRecord
  belongs_to :trip_advisor_location

  validates_numericality_of :review_average, less_than_or_equal_to: 5
end
