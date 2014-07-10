class FlipKeyProperty < ActiveRecord::Base
  has_one :property, dependent: :destroy

  def booked_on?(date)
    parsed_json['property_calendar'][0]['booked_date'].any? { |bd| bd == date.to_s }
  end

  def parsed_json
    @parsed_json ||= JSON.parse(json_data)
  end
end
