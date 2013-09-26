class PropertyPricer
  attr_accessor :property_number

  def initialize opts
    unless opts.include?(:property_number) && opts.include?(:months)
      raise ArgumentError.new("Options should include both :property_number and :months")
    end

    @months = opts[:months].to_i
    @property_number = opts[:property_number].to_i
  end

  def price_in_cents
    pbb = PropertyBasePrice.find_by(number_of_months: @months)
    raise "No matching PropertyBasePrice for months=#{@months}" if pbb.nil?
    pbb.price * (100 - volume_discount_percentage) - (volume_discount_amount * 100)
  end

  def volume_discount_percentage
    percentage_off = 0

    PropertyVolumeDiscount.order(:current_property_number).each do |pvd|
      percentage_off = pvd.discount_percentage if @property_number >= pvd.current_property_number
    end

    percentage_off
  end

  def volume_discount_amount
    discount_amount = 0

    PropertyVolumeDiscount.order(:current_property_number).each do |pvd|
      discount_amount = pvd.discount_amount if @property_number >= pvd.current_property_number
    end

    discount_amount
  end
end
