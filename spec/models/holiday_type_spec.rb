require "rails_helper"

describe HolidayType do
  describe "#to_param" do
    it "returns its slug" do
      expect(HolidayType.new(slug: "slug").to_param).to eq "slug"
    end
  end

  describe "#to_s" do
    it "returns its name" do
      expect(HolidayType.new(name: "Cruises").to_s).to eq "Cruises"
    end
  end
end
