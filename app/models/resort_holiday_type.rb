class ResortHolidayType < ActiveRecord::Base
  belongs_to :resort
  belongs_to :holiday_type
end
