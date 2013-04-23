class AltAttribute < ActiveRecord::Base
  validates_uniqueness_of :path
end
