class WindowGroup
  attr_accessor :starts_at, :expires_at, :total, :number_in_use
  SECONDS_IN_A_YEAR = 86400

  def initialize
    @total = @number_in_use = 0
  end

  def days_remaining
    ((@expires_at - Time.now) / SECONDS_IN_A_YEAR).to_i
  end

  def number_free
    @total - @number_in_use
  end
end
