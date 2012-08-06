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
    "<td class=\"availability-#{@vacancy.availability_on(date)}\">#{date.mday}</td>"
  end

  def empty_day_cell
    "<td class=\"empty\">&nbsp;</td>"
  end
end
