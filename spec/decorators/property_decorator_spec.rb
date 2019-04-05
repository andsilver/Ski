require "rails_helper"

describe PropertyDecorator do
  describe "#nearest_lift" do
    it "appends unit to metres_from_lift" do
      expect(Property.new(metres_from_lift: 500).decorate.nearest_lift).to eq "500m"
    end

    it "returns > 1km for 1001" do
      expect(Property.new(metres_from_lift: 1001).decorate.nearest_lift).to eq "> 1km"
    end
  end

  describe "#truncated_name" do
    it "returns the name as is when length <= 50" do
      name = "x" * 50
      expect(Property.new(name: name).decorate.truncated_name).to eq "x" * 50
    end

    it "returns the truncated name and ... when length > 50" do
      name = "x" * 51
      expect(Property.new(name: name).decorate.truncated_name).to eq "x" * 50 + "..."
    end
  end
end
