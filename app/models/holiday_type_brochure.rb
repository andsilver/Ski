class HolidayTypeBrochure < ActiveRecord::Base
  belongs_to :brochurable, polymorphic: true
  belongs_to :holiday_type

  validates :brochurable_id, presence: true, uniqueness: { scope: [:holiday_type, :brochurable_type] }
  validates :holiday_type, presence: true

  def featured_properties(limit)
    Property.order('RAND()')
      .limit(9)
      .where(publicly_visible: true, brochurable_type.foreign_key.to_sym => brochurable.id)
  end
end
