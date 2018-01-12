# frozen_string_literal: true

class OrderLine < ActiveRecord::Base
  belongs_to :order
  belongs_to :advert, optional: true
  belongs_to :coupon, optional: true
  belongs_to :country, optional: true
  belongs_to :resort, optional: true

  def to_s
    "##{id} #{amount} #{description} (#{order.status_description})"
  end
end
