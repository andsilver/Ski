require "rails_helper"

describe Website do
  describe "#vat_for" do
    it "calculates the VAT amount for a given price" do
      website = Website.new
      website.vat_rate = 20.0
      expect(website.vat_for(10)).to be_within(0.001).of(2.0)
    end
  end
end
