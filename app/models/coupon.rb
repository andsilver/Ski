class Coupon < ActiveRecord::Base
  has_many :users, :dependent => :nullify

  validates_presence_of :code
  validates_uniqueness_of :code
  validates_inclusion_of :free_adverts, :in => 1..1000
end
