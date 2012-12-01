class Favourite < ActiveRecord::Base
  attr_accessible :property_id

  belongs_to :property
  belongs_to :unregistered_user
  validates_uniqueness_of :property_id, scope: :unregistered_user_id
end
