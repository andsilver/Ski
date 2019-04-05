class InterhomeVacancy < ActiveRecord::Base
  def availability_on(date)
    get_value_for_date(availability, date)
  end

  def changeover_on(date)
    get_value_for_date(changeover, date)
  end

  def minstay_on(date)
    "0ABCDEFGHIJKLMNOPQRSTUVWXYZ".index(get_value_for_date(minstay, date))
  end

  def check_in_on?(date)
    "CI".include? changeover_on(date)
  end

  def check_out_on?(date)
    "CO".include? changeover_on(date)
  end

  def available_to_check_in_on_dates?(dates)
    dates.each {|d| return false if availability_on(d) != "Y" || !check_in_on?(d)}
    true
  end

  def available_nights(date)
    nights = []
    if check_in_on?(date)
      (1..28).each do |night|
        next_date = date + night.days
        if night >= minstay_on(date) && check_out_on?(next_date)
          nights << night
        end
        # Allow day of checkout to be unavailable but abort after that.
        break if availability_on(next_date) != "Y"
      end
    end
    nights
  end

  def get_value_for_date(values, date)
    index = (date - startday).to_i
    if index < 0 || index >= values.length
      "unknown"
    else
      values[index]
    end
  end
end
