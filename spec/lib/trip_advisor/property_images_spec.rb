# frozen_string_literal: true

require "rails_helper"

module TripAdvisor
  RSpec.describe PropertyImages do
    def json(id = 7_363_690)
      File.read(
        File.join(
          Rails.root, "test-files", "trip_advisor", "properties", "#{id}.json"
        )
      )
    end

    describe "#import" do
      let(:property) { FactoryBot.create(:property) }
      let(:images) { PropertyImages.new(property, json) }
      let(:first_image) { property.images.first }

      it "creates an image for each photo_url entry" do
        images.import
        expect(property.images.count).to eq 25
      end

      it "sets the source image to the jumbo URL" do
        images.import
        expect(first_image.source_url).to eq "https://media-cdn.tripadvisor.com/media/vr-splice-j/03/3f/d5/6e.jpg"
      end

      it "sets the main image to the first in the set when empty" do
        images.import
        expect(property.image).to eq first_image
      end

      it "leaves the main image alone when present" do
        image = FactoryBot.create(
          :image, property_id: property.id,
                  source_url: "https://media-cdn.tripadvisor.com/media/vr-splice-j/03/3f/d9/d5.jpg"
        )
        property.image = image
        property.save
        images.import
        expect(property.image).to eq image
      end

      it "deletes old images" do
        old_image = FactoryBot.create(
          :image, property_id: property.id, updated_at: Time.current - 2.days
        )
        images.import
        expect(Image.exists?(old_image.id)).to be_falsey
      end

      it "touches timestamp of older images still in set" do
        old_image = FactoryBot.create(
          :image, property_id: property.id, updated_at: Time.current - 2.days,
                  source_url: "https://media-cdn.tripadvisor.com/media/vr-splice-j/03/3f/d5/6e.jpg"
        )
        images.import
        old_image.reload
        expect(old_image.updated_at).to be > (Time.current - 5.seconds)
      end

      context "when property has no photos" do
        let(:images) { PropertyImages.new(property, json(8_500_992)) }
        it "imports no images without error" do
          images.import
          expect(property.images.count).to eq 0
        end
      end
    end
  end
end
