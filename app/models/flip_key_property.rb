class FlipKeyProperty < ActiveRecord::Base
  has_one :property, dependent: :destroy

  def booked_on?(date)
    parsed_json['property_calendar'][0]['booked_date'].any? { |bd| bd == date.to_s }
  end

  def parsed_json
    @parsed_json ||= JSON.parse(json_data)
  end

  def latitude
    parsed_json['property_addresses'][0]['latitude'][0]
  end

  def longitude
    parsed_json['property_addresses'][0]['longitude'][0]
  end

  def occupancy
    property_details['occupancy'][0].to_i
  end

  def bathroom_count
    property_details['bathroom_count'][0].to_i
  end

  def bedroom_count
    property_details['bedroom_count'][0].to_i
  end

  def property_type
    property_details['property_type'][0]
  end

  def property_details
    parsed_json['property_details'][0]
  end

  def rental_price
    day_min_rate || week_min_rate || month_min_rate
  end

  def day_min_rate
    property_rate_summary['day_min_rate'][0]
  end

  def property_rate_summary
    parsed_json['property_rate_summary'][0]
  end

  def rental_price_scope
    return 'per night' if day_min_rate
    return 'per week' if week_min_rate
    return 'per month' if month_min_rate
    return ''
  end
end
