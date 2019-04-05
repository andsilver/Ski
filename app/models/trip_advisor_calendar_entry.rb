# frozen_string_literal: true

class TripAdvisorCalendarEntry < ApplicationRecord
  BOOKED = "BOOKED"
  RESERVED = "RESERVED"
  STATUSES = [BOOKED, RESERVED]

  belongs_to :trip_advisor_property

  validates_inclusion_of :status, in: STATUSES
  validates_presence_of :inclusive_start, :exclusive_end
  validates_presence_of :trip_advisor_property_id
end
