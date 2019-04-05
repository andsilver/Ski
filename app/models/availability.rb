# frozen_string_literal: true

class Availability < ApplicationRecord
  belongs_to :property

  AVAILABILITIES = [
    UNAVAILABLE = 0,
    AVAILABLE = 1,
    ENQUIRE = 2,
  ]

  validates_inclusion_of :availability, in: AVAILABILITIES
  validates_inclusion_of :check_in, in: [true, false]
  validates_inclusion_of :check_out, in: [true, false]
  validates_presence_of :start_date

  # Deletes all availabilities where start_date is in the past.
  def self.delete_past
    Availability.where("start_date < ?", Date.current).delete_all
  end

  # Converts an availability code from an <tt>InterhomeVacancy</tt> into an
  # appropriate value for <tt>availability</tt>.
  def self.availability_from_interhome(availability_code)
    {
      "N" => UNAVAILABLE,
      "Y" => AVAILABLE,
      "Q" => ENQUIRE,
    }[availability_code]
  end
end
