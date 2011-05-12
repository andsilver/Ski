class PropertyVolumeDiscount < ActiveRecord::Base
  validates_uniqueness_of :current_property_number
end
