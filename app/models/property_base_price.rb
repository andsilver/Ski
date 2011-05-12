class PropertyBasePrice < ActiveRecord::Base
  validates_uniqueness_of :number_of_months
end
