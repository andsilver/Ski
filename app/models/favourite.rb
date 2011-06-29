class Favourite < ActiveRecord::Base
  belongs_to :property
  belongs_to :unregistered_user
  validates_uniqueness_of :property_id, :scope => :unregistered_user_id
end
