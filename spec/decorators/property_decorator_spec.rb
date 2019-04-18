require "rails_helper"

describe PropertyDecorator do
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
