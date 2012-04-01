class InterhomePlace < ActiveRecord::Base
  validates_uniqueness_of :code
end
