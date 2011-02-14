class Property < ActiveRecord::Base
  belongs_to :user
  belongs_to :resort

  validates_presence_of :resort_id
  validates_associated :resort

  cattr_reader :per_page
  @@per_page = 10
end
