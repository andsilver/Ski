require "rails_helper"

RSpec.describe PropertyOrdering do
  let(:controller_class) { Class.new { include PropertyOrdering } }
  let(:controller) { controller_class.new }

  describe "#order_whitelist" do
    it "returns normalised_weekly_rent_price ASC as its first (default) value" do
      expect(controller.order_whitelist.first).to eq("normalised_weekly_rent_price ASC")
    end
  end

  describe "#for_sale_order_whitelist" do
    it "returns normalised_sale_price ASC as its first (default) value" do
      expect(controller.for_sale_order_whitelist.first).to eq("normalised_sale_price ASC")
    end
  end
end
