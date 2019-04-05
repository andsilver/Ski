require "rails_helper"

describe Order do
  describe "#create_order_number" do
    it "assigns a string to order_number" do
      order = Order.new
      expect(order.order_number).to be_nil
      order.create_order_number
      expect(order.order_number).to_not be_nil
    end

    it "assigns a string 13 characters long: YYYYMMDD-ABCD" do
      order = Order.new
      order.create_order_number
      expect(order.order_number.length).to equal(13)
    end
  end
end
