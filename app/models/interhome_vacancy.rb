class InterhomeVacancy < ActiveRecord::Base
  def availability_on(date)
    get_value_for_date(availability, date)
  end

  def changeover_on(date)
    get_value_for_date(changeover, date)
  end

  def minstay_on(date)
    '0ABCDEFGHIJKLMNOPQRSTUVWXYZ'.index(get_value_for_date(minstay, date))
  end

  def check_in_on?(date)
    'CI'.include? changeover_on(date)
  end

  def available_to_check_in_on_dates?(dates)
    dates.each {|d| return false if availability_on(d) != 'Y' || !check_in_on?(d)}
    true
  end

  def get_value_for_date(values, date)
    index = (date - startday).to_i
    if index < 0 || index >= values.length
      'unknown'
    else
      values[index]
    end
  end
end
