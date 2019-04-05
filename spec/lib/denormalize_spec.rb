require "rails_helper"

describe Denormalize do
  describe ".denormalize" do
    before { allow(Currency).to receive(:update_exchange_rates) }

    it "updates featured properties" do
      expect(Denormalize).to receive(:update_featured_properties)
      Denormalize.denormalize
    end

    it "updates exchange rates" do
      expect(Currency).to receive(:update_exchange_rates)
      Denormalize.denormalize
    end

    it "updates properties" do
      expect(Denormalize).to receive(:update_properties)
      Denormalize.denormalize
    end

    it "updates resorts" do
      expect(Denormalize).to receive(:update_resorts)
      Denormalize.denormalize
    end

    it "updates countries" do
      expect(Denormalize).to receive(:update_countries)
      Denormalize.denormalize
    end

    it "updates regions" do
      expect(Denormalize).to receive(:update_regions)
      Denormalize.denormalize
    end
  end

  describe ".update_featured_properties" do
    context "without a website" do
      it "does not raise" do
        expect {Denormalize.update_featured_properties}.not_to raise_error
      end
    end

    context "with a website" do
      let!(:website) { Website.first || FactoryBot.create(:website) }

      it "assigns featured properties to the website" do
        featured_properties = [FactoryBot.create(:property)]
        expect(Property).to receive(:featured).and_return featured_properties
        Denormalize.update_featured_properties
        website.reload
        expect(website.featured_properties).to eq featured_properties
      end
    end
  end

  describe ".update_properties" do
    it "suspends geocoding" do
      expect(Property).to receive(:stop_geocoding)
      expect(Property).to receive(:resume_geocoding)
      Denormalize.update_properties
    end
  end

  describe ".update_resorts" do
    it "updates the for_rent count" do
      r = FactoryBot.create(:resort, visible: true)
      FactoryBot.create(
        :property, listing_type: Property::LISTING_TYPE_FOR_RENT, resort: r
      )
      Denormalize.update_resorts
      expect(r.reload.for_rent_count).to eq 1
    end
  end

  describe ".cache_availability" do
    it "deletes past availabilities" do
      expect(Availability).to receive(:delete_past)
      Denormalize.cache_availability
    end
  end
end
