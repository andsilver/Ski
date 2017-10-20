# frozen_string_literal: true

class TripAdvisorCalendarEntry < ApplicationRecord
  STATUSES = %w(BOOKED RESERVED)

  validates_inclusion_of :status, in: STATUSES
  validates_presence_of :inclusive_start, :exclusive_end
  validates_presence_of :trip_advisor_property_id
end
