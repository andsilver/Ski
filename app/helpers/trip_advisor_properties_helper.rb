# frozen_string_literal: true

module TripAdvisorPropertiesHelper
  # Given a TripAdvisorProperty, converts its check-in Dates into a string of
  # JavaScript that is a map of check-in to check-out dates in object format.
  #
  # +true+ is prepended to the value array for use with the pickadate.js date
  # disabling method.
  #
  #    '2014-08-23': [true, new Date(2014,7,30), new Date(2014,8,6)],
  #    '2014-08-30': [true, new Date(2014,8,6)]
  def javascript_check_out_dates(trip_advisor_property)
    trip_advisor_property.check_in_dates.map { |ci|
      "'#{ci}': [true, #{javascript_dates(trip_advisor_property.check_out_dates(ci))}]"
    }.join(",\n").html_safe
  end

  # Converts an array of Dates into a string containing a JavaScript comma
  # separated list of dates.
  def javascript_dates(dates)
    dates.map {|d| "new Date(#{d.strftime("%Y,%-m-1,%-d")})" }.join(", ").html_safe
  end
end
