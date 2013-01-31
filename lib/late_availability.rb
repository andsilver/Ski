module LateAvailability
  # Returns an array of dates for the next three Saturdays, not including
  # today.
  def self.next_three_saturdays
    saturdays = []
    21.times do |days_ahead|
      d = Date.today + 1 + days_ahead.days
      saturdays << d if d.saturday?
    end
    saturdays
  end
end
