require "rails_helper"

describe SidebarHelper do
  describe "#sidebar_html" do
    context "when only website sidebar HTML exists" do
      before do
        allow(helper).to receive(:website_sidebar_html).and_return("website sidebar HTML")
        allow(helper).to receive(:holiday_type_sidebar_html).and_return(nil)
      end

      it "returns website sidebar HTML" do
        expect(helper.sidebar_html).to eq("website sidebar HTML")
      end
    end

    context "when only holiday type sidebar HTML exists" do
      before do
        allow(helper).to receive(:holiday_type_sidebar_html).and_return("holiday type sidebar HTML")
        allow(helper).to receive(:website_sidebar_html).and_return(nil)
      end

      it "returns holiday type sidebar HTML" do
        expect(helper.sidebar_html).to eq("holiday type sidebar HTML")
      end
    end

    context "when website and holiday type sidebar HTML exist" do
      before do
        allow(helper).to receive(:holiday_type_sidebar_html).and_return("holiday type sidebar HTML")
        allow(helper).to receive(:website_sidebar_html).and_return("website sidebar HTML")
      end

      it "returns holiday type sidebar HTML" do
        expect(helper.sidebar_html).to eq("holiday type sidebar HTML")
      end
    end
  end

  describe "#website_sidebar_html" do
    it "returns website sidebar HTML belonging to @w" do
      assign(:w, double(Website, sidebar_html: "website sidebar HTML"))
      expect(helper.website_sidebar_html).to eq("website sidebar HTML")
    end
  end

  describe "#holiday_type_sidebar_html" do
    let(:ski) { double(HolidayType, sidebar_html: "ski HTML") }
    let(:lakes) { double(HolidayType, sidebar_html: "lakes HTML") }
    let(:city_breaks) { double(HolidayType, sidebar_html: "city breaks HTML") }
    let(:france) { double(Country) }
    let(:rhone_alpes) { double(Region) }
    let(:chamonix) { double(Resort) }

    it "returns sidebar HTML from @holiday_type" do
      assign(:holiday_type, ski)
      expect(helper.holiday_type_sidebar_html).to eq "ski HTML"
    end

    it "returns sidebar HTML from each @country holiday type" do
      allow(france).to receive(:holiday_types).and_return [ski, lakes]
      assign(:country, france)
      expect(helper.holiday_type_sidebar_html).to eq "ski HTMLlakes HTML"
    end

    it "returns sidebar HTML from each @region holiday type" do
      allow(rhone_alpes).to receive(:holiday_types).and_return [ski, lakes]
      assign(:region, rhone_alpes)
      expect(helper.holiday_type_sidebar_html).to eq "ski HTMLlakes HTML"
    end

    it "returns sidebar HTML from each @resort holiday type" do
      allow(chamonix).to receive(:holiday_types).and_return [ski, lakes]
      assign(:resort, chamonix)
      expect(helper.holiday_type_sidebar_html).to eq "ski HTMLlakes HTML"
    end

    it "returns all sidebar HTML once from holiday types via @holiday_type, @country, @region and @resort" do
      allow(france).to receive(:holiday_types).and_return [ski, lakes]
      allow(rhone_alpes).to receive(:holiday_types).and_return [ski, city_breaks]
      allow(chamonix).to receive(:holiday_types).and_return [ski, lakes]
      assign(:country, france)
      assign(:region, rhone_alpes)
      assign(:resort, chamonix)
      expect(helper.holiday_type_sidebar_html).to eq "ski HTMLlakes HTMLcity breaks HTML"
    end
  end
end
