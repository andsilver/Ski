# frozen_string_literal: true

require "rails_helper"

module TripAdvisor
  RSpec.describe PropertyImporter do
    def json(id = 7_363_690)
      File.read(
        File.join(
          Rails.root, "test-files", "trip_advisor", "properties", "#{id}.json"
        )
      )
    end

    describe "#import" do
      def null_object(klass)
        allow(klass)
          .to receive(:new)
          .and_return(instance_double(klass).as_null_object)
      end

      context "with malformed JSON" do
        let(:importer) { PropertyImporter.new(json(1_941_864)) }

        it "does not persist the property" do
          importer.import
          expect(TripAdvisorProperty.exists?(1_941_864)).to be_falsey
        end

        it "logs a warning" do
          expect(Rails.logger)
            .to receive(:warn)
            .with("Malformed JSON found in TripAdvisor::PropertyImporter")
          importer.import
        end
      end

      it "copies details" do
        details = instance_double(
          PropertyDetails, property: TripAdvisorProperty.new
        ).as_null_object
        expect(PropertyDetails)
          .to receive(:new)
          .with(JSON.parse(json))
          .and_return(details)
        expect(details).to receive(:import)

        null_object(BaseProperty)
        null_object(LongTermAdvert)
        null_object(PropertyImages)

        importer = PropertyImporter.new(json)
        importer.import
      end

      context "when TA property persisted" do
        let(:ta_prop) { instance_double(TripAdvisorProperty, persisted?: true, id: 123) }

        it "imports the calendar" do
          details = instance_double(PropertyDetails, property: ta_prop)
            .as_null_object
          allow(PropertyDetails).to receive(:new).and_return(details)

          importer = PropertyImporter.new(json)
          allow(importer).to receive(:create_base_property)
          allow(importer).to receive(:import_reviews)

          expect(importer).to receive(:import_calendar)
          importer.import
        end

        it "creates a base property" do
          details = instance_double(PropertyDetails, property: ta_prop)
            .as_null_object
          allow(PropertyDetails).to receive(:new).and_return(details)

          importer = PropertyImporter.new(json)
          allow(importer).to receive(:import_calendar)
          allow(importer).to receive(:import_reviews)

          expect(importer).to receive(:create_base_property)
          importer.import
        end

        it "advertises the property" do
          details = instance_double(PropertyDetails, property: ta_prop)
            .as_null_object
          allow(PropertyDetails).to receive(:new).and_return(details)

          prop = Property.new
          allow(BaseProperty)
            .to receive(:new)
            .and_return(instance_double(BaseProperty, create: prop))

          lta = instance_double(LongTermAdvert)
          expect(LongTermAdvert).to receive(:new).with(prop).and_return(lta)
          expect(lta).to receive(:create)

          null_object(PropertyCalendarImporter)
          null_object(PropertyImages)

          importer = PropertyImporter.new(json)
          allow(importer).to receive(:import_reviews)
          importer.import
        end

        it "imports images" do
          details = instance_double(PropertyDetails, property: ta_prop)
            .as_null_object
          allow(PropertyDetails).to receive(:new).and_return(details)

          importer = PropertyImporter.new(json)
          allow(importer).to receive(:import_calendar)
          allow(importer).to receive(:create_base_property)
          allow(importer).to receive(:import_reviews)

          expect(importer).to receive(:import_images)
          importer.import
        end

        it "imports amenities" do
          details = instance_double(PropertyDetails, property: ta_prop)
            .as_null_object
          allow(PropertyDetails).to receive(:new).and_return(details)

          importer = PropertyImporter.new(json)
          allow(importer).to receive(:import_calendar)
          allow(importer).to receive(:create_base_property)
          allow(importer).to receive(:import_reviews)

          expect(importer).to receive(:import_amenities)
          importer.import
        end

        it "imports reviews" do
          details = instance_double(PropertyDetails, property: ta_prop)
            .as_null_object
          allow(PropertyDetails).to receive(:new).and_return(details)

          importer = PropertyImporter.new(json)
          allow(importer).to receive(:import_calendar)
          allow(importer).to receive(:create_base_property)
          allow(importer).to receive(:import_amenities)

          expect(importer).to receive(:import_reviews)
          importer.import
        end
      end

      context "when TA property not persisted" do
        let(:ta_prop) do
          instance_double(TripAdvisorProperty, persisted?: false)
        end

        it "does not create a base property" do
          details = instance_double(PropertyDetails, property: ta_prop)
            .as_null_object
          allow(PropertyDetails).to receive(:new).and_return(details)

          expect(BaseProperty).not_to receive(:new)

          importer = PropertyImporter.new(json)
          importer.import
        end
      end
    end

    describe "#import_calendar" do
      it "uses a PropertyCalendarImporter" do
        ta_prop = instance_double(TripAdvisorProperty)

        pci = instance_double(PropertyCalendarImporter)
        expect(PropertyCalendarImporter)
          .to receive(:new)
          .with(ta_prop, JSON.parse(json)["calendar"])
          .and_return(pci)
        expect(pci).to receive(:import)

        importer = TripAdvisor::PropertyImporter.new(json)
        importer.ta_property = ta_prop
        importer.import_calendar
      end
    end

    describe "#create_base_property" do
      it "creates a new base property with the TA property and user" do
        ta_prop = instance_double(TripAdvisorProperty)
        bp = instance_double(BaseProperty)
        expect(BaseProperty).to receive(:new).with(ta_prop).and_return(bp)
        expect(bp).to receive(:create).with(TripAdvisor.user)

        importer = TripAdvisor::PropertyImporter.new("{}")
        importer.ta_property = ta_prop
        importer.create_base_property
      end
    end

    describe "#import_images" do
      it "uses PropertyImages to import images for the Property" do
        json = "{}"
        prop = instance_double(Property)

        pi = instance_double(PropertyImages)
        expect(PropertyImages)
          .to receive(:new).with(prop, json).and_return(pi)
        expect(pi).to receive(:import)

        importer = TripAdvisor::PropertyImporter.new(json)
        importer.property = prop
        importer.import_images
      end
    end

    describe "#import_amenities" do
      it "imports amenities from the details/amenities JSON array" do
        property = FactoryBot.create(:property)

        importer = TripAdvisor::PropertyImporter.new(json)
        importer.property = property
        importer.import_amenities

        expect(property.amenities.count).to eq 2
        expect(property).to have_amenity "DVD"
        expect(property).to have_amenity "ELDERLY_ACCESSIBLE"
      end

      it "deletes existing amenities" do
        property = FactoryBot.build(:property)
        property.amenities << FactoryBot.create(:amenity)
        property.save!

        importer = TripAdvisor::PropertyImporter.new(json)
        importer.property = property
        importer.import_amenities

        expect(property.amenities.count).to eq 2
      end
    end

    describe "#import_reviews" do
      it "imports reviews from the details/reviews JSON array" do
        property = FactoryBot.create(:property)

        importer = TripAdvisor::PropertyImporter.new(json)
        importer.property = property
        importer.import_reviews

        expect(property.reviews.count).to eq 1
        review = property.reviews.first
        expect(review.author_location).to eq "Bergheim, France"
        expect(review.author_name).to eq "Laetitia P"
        expect(review.content).to include "Connu sous le nom de Chalet des Ayes"
        expect(review.rating).to eq 5
        expect(review.title).to eq "Super!"
        expect(review.visited_on).to eq Date.new(2017, 4, 1)
      end

      it "deletes existing reviews" do
        property = FactoryBot.build(:property)
        property.reviews << FactoryBot.create(:review)
        property.save!

        importer = TripAdvisor::PropertyImporter.new(json)
        importer.property = property
        importer.import_reviews

        expect(property.reviews.count).to eq 1
      end
    end
  end
end
