# frozen_string_literal: true

class Availability < ActiveRecord::Base
  belongs_to :property

  AVAILABILITIES = [
    UNAVAILABLE = 0,
    AVAILABLE = 1,
    ENQUIRE = 2
  ]

  validates_inclusion_of :availability, in: AVAILABILITIES
  validates_presence_of :start_date

  # Converts an availability code from an <tt>InterhomeVacancy</tt> into an
  # appropriate value for <tt>availability</tt>.
  def self.availability_from_interhome(availability_code)
    {
      'N' => UNAVAILABLE,
      'Y' => AVAILABLE,
      'Q' => ENQUIRE
    }[availability_code]
  end
end
