class Calendar
  @start_month = 1
  @start_day = 1

  def days_in_month(month, year)
    if month < 1 || month > 12
      return 0
    end

    days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    d = days_in_month[month - 1]

    if month == 2
      # Check for leap year
      # Forget the 4000 rule, I doubt I'll be around then...

      if year % 4 == 0
        if year % 100 == 0
          if year % 400 == 0
            d = 29
          end
        else
          d = 29
        end
      end

    end

    d
  end

  def show_month(month, year)
    s = ""

    days = days_in_month month, year
    date = Date.new(year, month, 1)
    first = date.strftime("%w").to_i

    s = month_header(month, year)

    s += '<table class="' + table_class + '">'
    s += "<tr>\n"
    s += "<th>#{day_names[1]}</th>\n"
    s += "<th>#{day_names[2]}</th>\n"
    s += "<th>#{day_names[3]}</th>\n"
    s += "<th>#{day_names[4]}</th>\n"
    s += "<th>#{day_names[5]}</th>\n"
    s += "<th>#{day_names[6]}</th>\n"
    s += "<th>#{day_names[0]}</th>\n"
    s += "</tr>\n"

    # We need to work out what date to start at so that the first appears in the correct column
    d = 2 - first
    d -= 7 while d > 1

    while d <= days
      s += "<tr>\n"

      (0..6).each do |i|
        if (d > 0) && (d <= days)
          day = Date.new(year, month, d)
          s += day_cell(day)
        else
          s += empty_day_cell
        end
        d += 1
      end

      s += "</tr>\n"
    end

    s += "</table>\n"
  end

  def day_names
    ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
  end

  def month_names
    ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
  end

  def day_cell(date)
    "<td><p class=\"day\">#{date.mday}</p></td>"
  end

  def month_header(month, year)
    "<h2>" + month_names[month - 1] + " " + year.to_s + "</h2>"
  end

  def empty_day_cell
    "<td>&nbsp;</td>"
  end

  def table_class
    "calendar"
  end
end
