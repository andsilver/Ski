# Property base prices represent the price of a single property,
# applicable to both for sale and to let, for the set number of months
#
# An example:
# 1 month: 25 EUR
# 3 months: 55 EUR
# 6 months: 89 EUR
# 12 months: 149 EUR

class PropertyBasePrice < ActiveRecord::Base
  validates_uniqueness_of :number_of_months
end
