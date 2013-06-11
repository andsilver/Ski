class HolidayTypeBrochure < ActiveRecord::Base
  belongs_to :brochurable, polymorphic: true
  belongs_to :holiday_type

  validates :brochurable_id, presence: true, uniqueness: { scope: :holiday_type }
  validates :holiday_type, presence: true
end
