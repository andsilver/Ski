# frozen_string_literal: true

require "rails_helper"

module TripAdvisor
  RSpec.describe BaseProperty do
    describe "#create" do
      let(:user) { FactoryBot.create(:user) }
      let(:resort) { FactoryBot.create(:resort) }
      let(:gbp) { FactoryBot.create(:currency) }
      let(:ta_prop) do
        FactoryBot.create(
          :trip_advisor_property,
          bedrooms: 6,
          sleeps: 8,
          bathrooms: 2,
          title: "title",
          description: "description",
          id: 1,
          starting_price: 112,
          currency: gbp
        )
      end

      before do
        allow(ta_prop).to receive(:resort).and_return(resort)
        @property = BaseProperty.new(ta_prop).create(user)
      end

      it "creates a property" do
        expect(Property.count).to eq 1
      end

      it "sets the name" do
        expect(@property.name).to eq "title"
      end

      it "sets the description" do
        expect(@property.description).to eq "description"
      end

      it "sets the strapline" do
        expect(@property.strapline).to eq "description"
      end

      it "sets the resort to the TripAdvisorProperty resort" do
        expect(@property.resort).to eq resort
      end

      it "sets the currency to the TripAdvisorProperty currency" do
        expect(@property.currency).to eq gbp
      end

      it "sets the user to the user param" do
        expect(@property.user).to eq user
      end

      it "sets the trip_advisor_property association" do
        expect(@property.trip_advisor_property).to eq ta_prop
      end

      it "sets the property as for rent" do
        expect(@property.listing_type).to eq Property::LISTING_TYPE_FOR_RENT
      end

      it "sets the number of bedrooms" do
        expect(@property.number_of_bedrooms).to eq 6
      end

      it "sets the sleeping capacity" do
        expect(@property.sleeping_capacity).to eq 8
      end

      it "sets the number of bathrooms" do
        expect(@property.number_of_bathrooms).to eq 2
      end

      it "sets the weekly rent price" do
        expect(@property.weekly_rent_price).to eq(112 * 7)
      end
    end
  end
end
