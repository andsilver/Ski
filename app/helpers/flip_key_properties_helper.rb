module FlipKeyPropertiesHelper
  def flip_key_property_description(json)
    raw json['property_descriptions'][0]['property_description'][0]['description'][0].gsub("\n", '<br>')
  end

  def flip_key_rate(property, value)
    if value.nil? || value[0].kind_of?(Hash)
      flip_key_rate_not_listed
    else
      format_currency(value[0], property.currency)
    end
  end

  def flip_key_rate_not_listed
    content_tag(:div, 'Not listed')
  end

  def flip_key_minimum_stay(rate)
    pluralize(rate['min_stay_count'][0], rate['min_stay_unit'][0])
  end

  def flip_key_changeover(changeover)
    return 'Check in any day' if changeover.kind_of?(Hash)
    %w{Sunday Monday Tuesday Wednesday Thursday Friday Saturday}[changeover.to_i] + ' check-in'
  end

  # Given a FlipKeyProperty, converts its check-in Dates into a string of
  # JavaScript that is a map of check-in to check-out dates in object format.
  #
  # +true+ is prepended to the value array for use with the pickadate.js date
  # disabling method.
  #
  #    '2014-08-23': [true, new Date(2014,7,30), new Date(2014,8,6)],
  #    '2014-08-30': [true, new Date(2014,8,6)]
  def javascript_check_out_dates(flip_key_property)
    flip_key_property.check_in_dates.map do |ci|
      "'#{ci.to_s}': [true, #{javascript_dates(flip_key_property.check_out_dates(ci))}]"
    end.join(",\n").html_safe
  end

  # Converts an array of Dates into a string containing a JavaScript comma
  # separated list of dates.
  def javascript_dates(dates)
    dates.map {|d| "new Date(#{d.strftime('%Y,%-m-1,%-d')})" }.join(', ').html_safe
  end
end
