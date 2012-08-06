class InterhomeVacancy < ActiveRecord::Base
  attr_accessible :accommodation_code, :availability, :changeover, :flexbooking, :interhome_accommodation_id, :minstay, :startday

  def availability_on(date)
    get_value_for_date(availability, date)
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
