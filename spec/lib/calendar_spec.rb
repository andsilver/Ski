require "rails_helper"

describe Calendar do
  describe "#days_in_month" do
    it "returns 0 when month is out of bounds (1-12)" do
      expect(Calendar.new.days_in_month(0, 2020)).to eq 0
      expect(Calendar.new.days_in_month(13, 2020)).to eq 0
    end

    it "returns the number of days in a consistent month" do
      expect(Calendar.new.days_in_month(1, 2020)).to eq 31
    end

    it "returns 28 days for February in a non-leap year" do
      expect(Calendar.new.days_in_month(2, 2019)).to eq 28
    end

    it "returns 29 days for February in a leap year" do
      expect(Calendar.new.days_in_month(2, 2020)).to eq 29
    end
  end
end
