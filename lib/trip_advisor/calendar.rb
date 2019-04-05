module TripAdvisor
  class Calendar < ::Calendar
    def initialize(trip_advisor_property)
      @property = trip_advisor_property
    end

    def day_names
      ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]
    end

    def table_class
      "interhome-calendar"
    end

    def day_cell(date)
      if @property.booked_on?(date)
        class_attr = "N"
        title_attr = "Unavailable"
      else
        class_attr = "Y"
        title_attr = "Available"
      end
      "<td class=\"availability-#{class_attr}\" title=\"#{title_attr}\" data-day=\"#{date.to_s[8..9].to_i}\" data-month=\"#{date.to_s[0..6]}\">#{date.mday}</td>"
    end

    def empty_day_cell
      "<td class=\"empty\">&nbsp;</td>"
    end
  end
end
