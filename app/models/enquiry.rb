class Enquiry < ActiveRecord::Base
  belongs_to :user
  belongs_to :property

  validates_presence_of :name
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_presence_of :phone
end
