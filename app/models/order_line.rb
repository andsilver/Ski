class OrderLine < ActiveRecord::Base
  belongs_to :order
  belongs_to :advert
  belongs_to :coupon
  belongs_to :country
  belongs_to :resort
end
