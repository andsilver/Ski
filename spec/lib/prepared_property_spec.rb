# frozen_string_literal: true

require "rails_helper"

RSpec.describe PreparedProperty do
  describe "#property" do
    let(:user) { FactoryBot.create(:user) }
    let(:object) { PreparedProperty.new({trip_advisor_property_id: 123}, user) }
    let(:property) { object.property }

    it "sets publicly_visible to true" do
      expect(property.publicly_visible?).to be_truthy
    end

    it "sets the user" do
      expect(property.user).to eq user
    end

    context "when property exists" do
      let!(:existing_prop) { FactoryBot.create(:property, trip_advisor_property_id: 123) }

      context "when property has existing advert" do
        let!(:advert) do
          lta = LongTermAdvert.new(existing_prop)
          lta.create
          lta.advert
        end
        it "deletes the advert" do
          object.property
          expect(Advert.exists?(advert.id)).to be_falsey
        end
      end

      context "when property has no existing advert" do
        it "does not fail" do
          expect { object.property }.not_to raise_error
        end
      end
    end

    context "when property does not exist" do
      it "sets the provider property association key" do
        expect(object.property.trip_advisor_property_id).to eq 123
      end
    end
  end
end
