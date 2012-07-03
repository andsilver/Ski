class AltAttribute < ActiveRecord::Base
  attr_accessible :alt_text, :path

  validates_uniqueness_of :path
end
