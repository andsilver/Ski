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
    PropertyBasePrice.find_by_number_of_months(@months).price * (100 - volume_discount)
  end

  def volume_discount
    percentage_off = 0

    PropertyVolumeDiscount.order(:current_property_number).all.each do |pvd|
      percentage_off = pvd.discount_percentage if @property_number >= pvd.current_property_number
    end

    percentage_off
  end
end
