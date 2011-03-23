class DirectoryAdvert < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  validates_presence_of :category
  validates_presence_of :user
  validates_presence_of :business_address
end
