# frozen_string_literal: true

class TripAdvisorProperty < ApplicationRecord
  has_one :property, dependent: :destroy
  belongs_to :trip_advisor_location
  delegate :resort, to: :trip_advisor_location, allow_nil: true
  belongs_to :currency
  has_many :trip_advisor_calendar_entries, dependent: :delete_all

  validates_numericality_of :review_average, less_than_or_equal_to: 5
  validates_presence_of :currency
  validates_presence_of :resort
  validates_presence_of :starting_price

  def cache_availability(dates)
    dates.each do |date|
      Availability.create!(
        property: property,
        availability: availability_for(date),
        check_in: true,
        check_out: true,
        start_date: date
      )
    end
  end

  private

  def availability_for(date)
    if booked_on? date
      Availability::UNAVAILABLE
    else
      Availability::AVAILABLE
    end
  end

  def booked_on?(date)
    (@booked_dates ||= booked_dates)[date]
  end

  def booked_dates
    dates = {}
    trip_advisor_calendar_entries.all.each do |entry|
      date = entry.inclusive_start
      while date < entry.exclusive_end
        dates[date] = entry
        date = (date + 1.day)
      end
    end
    dates
  end
end
