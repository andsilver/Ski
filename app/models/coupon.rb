class Coupon < ActiveRecord::Base
  has_many :users, dependent: :nullify
  has_many :order_lines

  validates_presence_of :code
  validates_uniqueness_of :code
  validates_inclusion_of :number_of_adverts, in: 1..1000000, message: "is not in the range 1-1000000"

  def expired?
    !expires_on.nil? && Date.today > expires_on
  end
end
