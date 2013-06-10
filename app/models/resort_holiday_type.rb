class ResortHolidayType < ActiveRecord::Base
  belongs_to :resort
  belongs_to :holiday_type

  validates :resort, presence: true, uniqueness: { scope: :holiday_type }
  validates :holiday_type, presence: true
end
