class WindowBasePrice < ActiveRecord::Base
  validates_uniqueness_of :quantity
end
