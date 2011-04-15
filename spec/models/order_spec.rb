require 'spec_helper'

describe Order do
  describe "#create_order_number" do
    it "assigns a string to order_number" do
      order = Order.new
      order.order_number.should be_nil
      order.create_order_number
      order.order_number.should_not be_nil
    end

    it "assigns a string 13 characters long: YYYYMMDD-ABCD" do
      order = Order.new
      order.create_order_number
      order.order_number.length.should equal(13)
    end
  end
end
