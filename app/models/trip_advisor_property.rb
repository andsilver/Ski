# frozen_string_literal: true

class TripAdvisorProperty < ApplicationRecord
  has_one :property, dependent: :destroy
  belongs_to :trip_advisor_location
  delegate :resort, to: :trip_advisor_location, allow_nil: true
  belongs_to :currency
  has_many :trip_advisor_calendar_entries, dependent: :delete_all

  validates_length_of(
    :title, within: Property::MIN_NAME_LENGTH..Property::MAX_NAME_LENGTH
  )
  validates_numericality_of :review_average, less_than_or_equal_to: 5
  validates_presence_of :currency
  validates_numericality_of :min_stay_high
  validates_numericality_of :min_stay_low
  validates_numericality_of :sleeps
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

  # Deletes all calendar entries.
  def clear_calendar
    trip_advisor_calendar_entries.delete_all
  end

  def booked_on?(date)
    (@booked_dates ||= booked_dates)[date]
  end

  # Returns an array of Dates where check-in is possible.
  def check_in_dates
    dates = []
    today = Date.today
    (0..365).each do |days|
      date = today + days.days
      dates << date if check_in_on?(date)
    end
    dates
  end

  # TODO: Improve this naive test.
  def check_in_on?(date)
    !booked_on?(date)
  end

  # Returns valid check out dates for the given check in date, up to a
  # maximum stay length of 30 days.
  def check_out_dates(check_in)
    dates = []
    (min_stay_low..30).each do |days|
      date = check_in + days.days
      dates << date
      break if booked_on?(date)
    end
    dates
  end

  private

  def availability_for(date)
    if booked_on? date
      Availability::UNAVAILABLE
    else
      Availability::AVAILABLE
    end
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
