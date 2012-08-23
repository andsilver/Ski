class InterhomeCalendar < Calendar
  def initialize(vacancy)
    @vacancy = vacancy
  end

  def day_names
    ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]
  end

  def table_class
    'interhome-calendar'
  end

  def day_cell(date)
    class_attr = availability = @vacancy.availability_on(date)
    title_attr = ''
    if availability == 'Y'
      if !@vacancy.check_in_on?(date)
        class_attr = 'Y-no-check-in'
        title_attr = 'No check in'
      else
        title_attr = "Min stay: #{@vacancy.minstay_on(date)} days"
      end
    elsif availability == 'N' || availability == 'unknown'
      title_attr = 'Unavailable'
    elsif availability == 'Q'
      title_attr = 'Booking possible only on request'
    end
    "<td class=\"availability-#{class_attr}\" title=\"#{title_attr}\" data-day=\"#{date.to_s[8..9].to_i}\" data-month=\"#{date.to_s[0..6]}\">#{date.mday}</td>"
  end

  def empty_day_cell
    "<td class=\"empty\">&nbsp;</td>"
  end
end
