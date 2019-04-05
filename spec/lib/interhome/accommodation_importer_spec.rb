require "rails_helper"
require "xmlsimple"

module Interhome
  RSpec.describe AccommodationImporter do
    describe "#import_pictures" do
      let(:accommodation) { FactoryBot.create(:interhome_accommodation) }
      context "with pictures containing all properties" do
        let(:a) {
          {
            "pictures" =>
            [
              {
                "picture" => [
                  {
                    "url" => ["#"],
                    "type" => ["i"],
                    "season" => ["s"],
                  },
                ],
              },
            ],
          }
        }
        it "adds a picture with given properties" do
          importer = Interhome::AccommodationImporter.new
          importer.import_pictures(accommodation, a)
          p = accommodation.interhome_pictures.last
          expect(p.picture_type).to eq "i"
        end
      end

      context "with pictures missing properties" do
        let(:a) {
          {
            "pictures" =>
            [
              {
                "picture" => [
                  {
                  },
                ],
              },
            ],
          }
        }
        it "adds a picture with missing properties" do
          importer = Interhome::AccommodationImporter.new
          importer.import_pictures(accommodation, a)
          expect(accommodation.interhome_pictures.count).to eq 1
        end
      end
    end

    describe "#create_property" do
      it "sets the property currency to GBP" do
        gbp = FactoryBot.create(:currency, code: "GBP")
        resort = FactoryBot.create(:resort)
        accommodation = double(
          InterhomeAccommodation,
          id: 1, bedrooms: 3, current_price: 123, features: [],
          geodata_lat: 0, geodata_lng: 0,
          inside_description: "inside",
          name: "name", pax: 6
        ).as_null_object
        object = AccommodationImporter.new
        object.user = FactoryBot.create(:user)
        object.create_property(accommodation, resort.id, "address")

        property = Property.last
        expect(property.currency).to eq gbp
      end
    end
  end
end
