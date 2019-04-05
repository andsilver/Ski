# frozen_string_literal: true

require "rails_helper"

RSpec.describe Property, type: :model do
  describe "associations" do
    it { should have_many(:images) }
    it { should have_many(:adverts) }
    it { should have_and_belong_to_many(:amenities) }
    it { should have_many(:availabilities).dependent(:delete_all) }
    it { should belong_to(:trip_advisor_property) }
  end

  # ActiveModel
  it { should validate_length_of(:name).is_at_least(4).is_at_most(255) }
  it { should validate_presence_of(:resort) }
  it { should validate_inclusion_of(:layout).in_array(Property::LAYOUTS) }

  describe ".parking_description" do
    pending
  end

  describe "#parking_description" do
    pending
  end

  describe ".tv_description" do
    pending
  end

  describe "#tv_description" do
    pending
  end

  describe ".board_basis_description" do
    pending
  end

  describe "#board_basis_description" do
    pending
  end

  describe ".normalise_prices" do
    pending
  end

  describe ".importable_attributes" do
    pending
  end

  describe "#to_param" do
    pending
  end

  describe "#for_rent?" do
    it "returns true when listing_type is LISTING_TYPE_FOR_RENT" do
      property = Property.new(listing_type: Property::LISTING_TYPE_FOR_RENT)
      expect(property.for_rent?).to be_truthy
    end

    it "returns false when listing_type is anything else" do
      property = Property.new(listing_type: Property::LISTING_TYPE_FOR_SALE)
      expect(property.for_rent?).to be_falsey
    end
  end

  describe "#for_sale?" do
    it "returns true when listing_type is LISTING_TYPE_FOR_SALE" do
      property = Property.new(listing_type: Property::LISTING_TYPE_FOR_SALE)
      expect(property.for_sale?).to be_truthy
    end
  end

  describe "#price" do
    pending
  end

  describe "#has_amenity?" do
    it "returns truthy if property has an amenity with the given name" do
      property = FactoryBot.create(:property)
      property.amenities << Amenity.create(name: "DVD")
      expect(property).to have_amenity "DVD"
    end

    it "returns falsey if property has no amenity with the given name" do
      expect(Property.new).not_to have_amenity "DVD"
    end
  end

  describe "#features" do
    pending
  end

  describe "#adjust_distances_if_needed" do
    pending
  end

  describe "#closest_distance" do
    pending
  end

  describe "#geocode" do
    pending
  end

  describe "#attempt_geocode" do
    pending
  end

  describe "#normalise_prices" do
    pending
  end

  describe "#properties_for_rent_cannot_be_new_developments" do
    pending
  end

  describe "#valid_months" do
    let(:property) { Property.new }

    it "returns a sorted array of months from Property Base Prices" do
      PropertyBasePrice.delete_all
      PropertyBasePrice.create!([
        {number_of_months: 3,  price: 55},
        {number_of_months: 12, price: 149},
        {number_of_months: 6,  price: 89},
      ])
      expect(property.valid_months).to eq [3, 6, 12]
    end
  end

  describe "#cache_availability" do
    it "deletes existing availabilities for the property" do
      property = FactoryBot.create(:property)
      FactoryBot.create(:availability, property: property)

      property.cache_availability([])

      expect(property.availabilities.count).to eq 0
    end

    [TripAdvisorProperty, InterhomeAccommodation].each do |klass|
      it "delegates to its #{klass}" do
        property = Property.new
        sub_prop = klass.new
        setter = klass.to_s.underscore + "="
        property.send(setter, sub_prop)
        dates = [Date.current]

        expect(sub_prop).to receive(:cache_availability).with(dates)

        property.cache_availability(dates)
      end
    end
  end

  describe "#default_months" do
    let(:property) { Property.new }

    context "when property is for sale" do
      it "returns 3" do
        property.listing_type = Property::LISTING_TYPE_FOR_SALE
        expect(property.default_months).to eq 3
      end
    end

    context "when property is for rent" do
      it "returns 12" do
        property.listing_type = Property::LISTING_TYPE_FOR_RENT
        expect(property.default_months).to eq 12
      end
    end
  end

  describe "#tidy_name_and_strapline" do
    let(:property) { Property.new }

    context "when the strapline is blank" do
      context "when the description is blank" do
        it "leaves the strapline blank" do
          property.tidy_name_and_strapline
          expect(property.strapline).to eq("")
        end
      end

      context "when the description is not blank" do
        it "leaves sets the strapline to the first 252 chars of description with an elipsis" do
          property.description = "x" * 256
          property.tidy_name_and_strapline
          expect(property.strapline).to eq("x" * 252 + "...")
        end
      end
    end

    context "when the strapline is not blank" do
      it "truncates strapline to 252 chars with an elipsis" do
        property.strapline = "x" * 256
        property.tidy_name_and_strapline
        expect(property.strapline).to eq("x" * 252 + "...")
      end
    end

    it "truncates name to 255 chars" do
      property.name = "x" * 256
      property.tidy_name_and_strapline
      expect(property.name).to eq("x" * 255)
    end
  end

  describe "#calculate_late_availability" do
    context "when not Interhome accommodation" do
      it "returns true if the property is not for sale" do
        p = Property.new(listing_type: Property::LISTING_TYPE_FOR_RENT)
        expect(p.calculate_late_availability([])).to be_truthy
      end

      it "returns false if the property is for sale" do
        p = Property.new(listing_type: Property::LISTING_TYPE_FOR_SALE)
        expect(p.calculate_late_availability([])).to be_falsey
      end
    end

    it "returns the value of the Interhome accommodation availability" do
      available = InterhomeAccommodation.new
      expect(available).to receive(:available_to_check_in_on_dates?).and_return(true)
      p = Property.new
      p.interhome_accommodation = available
      expect(p.calculate_late_availability([])).to be_truthy

      unavailable = InterhomeAccommodation.new
      allow(unavailable).to receive(:available_to_check_in_on_dates?).and_return(false)
      p.interhome_accommodation = unavailable
      expect(p.calculate_late_availability([])).to be_falsey
    end
  end

  describe "#set_country_and_region" do
    let(:property) { FactoryBot.build(:property) }

    before do
      @country = FactoryBot.create(:country)
      @region = FactoryBot.create(:region, country_id: @country.id)
      @resort = FactoryBot.create(:resort, country_id: @country.id, region_id: @region.id)

      property.resort = @resort
      property.set_country_and_region
    end

    it "sets country" do
      expect(property.country).to eq @country
    end

    it "sets region" do
      expect(property.region).to eq @region
    end
  end

  describe "#template" do
    let(:property) do
      Property.new(layout: layout, trip_advisor_property: ta_prop)
    end
    let(:ta_prop) { nil }
    let(:new_development?) { false }

    before do
      allow(property).to receive(:new_development?).and_return new_development?
    end

    subject { property.template }

    context "when layout is set" do
      let(:layout) { "Cool Layout" }
      it { should eq "show_cool_layout" }
    end

    context "when layout not set" do
      let(:layout) { nil }

      context "when neither a new development nor FlipKey" do
        it { should eq "show_classic" }
      end

      context "when a new development" do
        let(:new_development?) { true }
        it { should eq "show_showcase" }
      end

      context "when a TripAdvisor property" do
        let(:ta_prop) { TripAdvisorProperty.new }
        it { should eq "show_trip_advisor" }
      end
    end
  end

  describe "before_save" do
    let(:property) { FactoryBot.create(:property) }

    it "calls set_country_and_region" do
      expect(property).to receive(:set_country_and_region)
      property.save
    end
  end

  describe "before_validation" do
    it "sets empty string layout to nil" do
      property = FactoryBot.create(:property)
      property.layout = ""
      property.save
      expect(property.layout).to be_nil
    end
  end
end
