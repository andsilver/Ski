class PropertyPricer
  attr_accessor :property_number

  BASE_PRICES = { 1 => 15, 3 => 40, 6 => 75, 9 => 80, 12 => 99 }
  VOLUME_DISCOUNTS = { 1 => 0, 3 => 5, 11 => 7, 21 => 10, 31 => 15,
    51 => 20, 101 => 25, 201 => 30, 301 => 35 }

  def initialize opts
    unless opts.include?(:property_number) && opts.include?(:months)
      raise ArgumentError.new("Options should include both :property_number and :months")
    end

    @months = opts[:months].to_i
    @property_number = opts[:property_number].to_i
  end

  def price_in_cents
    base_price = BASE_PRICES[@months] * (100 - volume_discount)
  end

  def volume_discount
    percentage_off = 0

    VOLUME_DISCOUNTS.each_pair do |threshold, p_o|
      percentage_off = p_o if @property_number >= threshold
    end

    percentage_off
  end
end
