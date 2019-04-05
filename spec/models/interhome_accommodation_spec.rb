require "rails_helper"

RSpec.describe InterhomeAccommodation, type: :model do
  describe "#check_in_on_dates?" do
    it "returns false when there is no InterhomeVacancy" do
      expect(InterhomeAccommodation.new.available_to_check_in_on_dates?([])).to be_falsey
    end

    it "delegates to InterhomeVacancy" do
      accom = InterhomeAccommodation.new

      available = InterhomeVacancy.new
      allow(available).to receive(:available_to_check_in_on_dates?).and_return(true)
      allow(available).to receive(:[]=).and_return(nil)
      allow(available).to receive(:delete).and_return(true)
      accom.interhome_vacancy = available
      expect(accom.available_to_check_in_on_dates?([])).to be_truthy

      unavailable = InterhomeVacancy.new
      allow(unavailable).to receive(:available_to_check_in_on_dates?).and_return(false)
      allow(unavailable).to receive(:[]=).and_return(nil)
      accom.interhome_vacancy = unavailable
      expect(accom.available_to_check_in_on_dates?([])).to be_falsey
    end
  end

  describe "#feature_list" do
    it "returns features split by comma" do
      expect(InterhomeAccommodation.new(features: "shower,bbq").feature_list).to eq ["shower", "bbq"]
    end

    it "returns an empty array when features is nil" do
      expect(InterhomeAccommodation.new(features: nil).feature_list).to eq []
    end
  end

  describe "#cache_availability" do
    let(:accommodation) { FactoryBot.create(:interhome_accommodation) }
    let!(:property) do
      FactoryBot.create(:property, interhome_accommodation: accommodation)
    end
    let!(:vacancy) {
      InterhomeVacancy.create!(
        interhome_accommodation_id: accommodation.id,
        startday: "2015-02-23",
        accommodation_code: "AT0000.000.0",
        availability: "NYQN",
        changeover: "XCIO"
      )
    }
    let(:d1) { Date.parse("2015-02-23") }
    let(:d2) { Date.parse("2015-02-24") }
    let(:d3) { Date.parse("2015-02-25") }
    let(:d4) { Date.parse("2015-02-26") }

    it "creates multiple Availabilities" do
      accommodation.cache_availability([d1, d2])
      expect(Availability.count).to eq 2
    end

    it "associates the availability with its property" do
      accommodation.cache_availability([d1])
      expect(Availability.first.property).to eq property
    end

    it "records no availability" do
      accommodation.cache_availability([d1])
      expect(Availability.first.availability).to eq Availability::UNAVAILABLE
    end

    it "records availability" do
      accommodation.cache_availability([d2])
      expect(Availability.first.availability).to eq Availability::AVAILABLE
    end

    it "records no availability when no vacancy information" do
      accommodation.cache_availability([Date.parse("2015-02-27")])
      expect(Availability.first.availability).to eq Availability::UNAVAILABLE
    end

    it "records enquire for availability" do
      accommodation.cache_availability([d3])
      expect(Availability.first.availability).to eq Availability::ENQUIRE
    end

    context "for X" do
      before { accommodation.cache_availability([d1]) }
      it "records no check-in" do
        expect(Availability.first.check_in?).to be_falsey
      end
      it "records no check-out" do
        expect(Availability.first.check_out?).to be_falsey
      end
    end

    context "for C" do
      before { accommodation.cache_availability([d2]) }
      it "records check-in" do
        expect(Availability.first.check_in?).to be_truthy
      end
      it "records check-out" do
        expect(Availability.first.check_out?).to be_truthy
      end
    end

    context "for I" do
      before { accommodation.cache_availability([d3]) }
      it "records check-in" do
        expect(Availability.first.check_in?).to be_truthy
      end
      it "records no check-out" do
        expect(Availability.first.check_out?).to be_falsey
      end
    end

    context "for O" do
      before { accommodation.cache_availability([d4]) }
      it "records no check-in" do
        expect(Availability.first.check_in?).to be_falsey
      end
      it "records check-out" do
        expect(Availability.first.check_out?).to be_truthy
      end
    end
  end
end
