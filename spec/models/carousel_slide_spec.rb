require "rails_helper"

describe CarouselSlide do
  describe ".active" do
    it "returns carousel slides that, based on current time, are currently active" do
      active_slide    = FactoryBot.create(:carousel_slide, active_from: Date.today - 1.day, active_until: Date.today + 1.day)
      _inactive_slide = FactoryBot.create(:carousel_slide, active_from: Date.today + 1.day, active_until: Date.today + 2.days)
      _expired_slide  = FactoryBot.create(:carousel_slide, active_from: Date.today - 2.days, active_until: Date.today - 1.day)
      expect(CarouselSlide.active.count).to eq 1
      expect(CarouselSlide.active.first).to eq active_slide
    end
  end

  describe "#ensure_active_range" do
    it "sets active_from and active_until if they are nil" do
      cs = CarouselSlide.new
      cs.save
      expect(cs.active_from).to be < Date.today
      expect(cs.active_until).to be > Date.today + 1.year
    end
  end

  describe "#to_s" do
    it "returns its caption" do
      expect(CarouselSlide.new(caption: "x").to_s).to eq "x"
    end
  end
end
