require "rails_helper"

RSpec.describe PropertiesHelper, type: :helper do
  describe "#featured_properties" do
    it "returns an empty string when properties is nil" do
      expect(featured_properties(nil)).to eq ""
    end

    it "renders no more than 3 properties" do
      properties = []
      4.times { properties << FactoryBot.create(:property) }
      html = featured_properties(properties)
      expect(html).to have_selector("[title='#{properties[2].name}']")
      expect(html).not_to have_selector("[title='#{properties[3].name}']")
    end
  end

  describe "#property_detail_path" do
    let(:property) { FactoryBot.create(:property) }

    it "returns a property_path for a native property" do
      expect(property_detail_path(property)).to eq property_path(property)
    end

    it "returns an interhome_property_path for an Interhome property" do
      interhome_accommodation = FactoryBot.create(:interhome_accommodation)
      property.interhome_accommodation = interhome_accommodation
      expect(property_detail_path(property)).to eq interhome_property_path(interhome_accommodation.permalink)
    end
  end

  describe "#booking_url" do
    let(:property) { FactoryBot.build(:property, booking_url: url) }

    context "when property has the booking URL set" do
      let(:url) { "#booking" }

      it "returns the booking URL" do
        expect(booking_url(property)).to eq "#booking"
      end
    end

    context "when property has no booking URL set" do
      let(:url) { "" }

      it "returns a contact_property_path" do
        expect(booking_url(property)).to eq contact_property_path(property)
      end
    end
  end

  describe "#booking_link_target" do
    let(:property) { FactoryBot.build(:property, booking_url: booking_url) }

    context "when property has the booking URL set" do
      let(:booking_url) { "#booking" }

      it "returns _blank" do
        expect(booking_link_target(property)).to eq "_blank"
      end
    end

    context "when property has no booking URL set" do
      let(:booking_url) { "" }

      it "returns _self" do
        expect(booking_link_target(property)).to eq "_self"
      end
    end
  end

  describe "#booking_link_text_key" do
    let(:property) { Property.new(listing_type: type) }
    subject { booking_link_text_key(property) }

    context "when property is for sale" do
      let(:type) { Property::LISTING_TYPE_FOR_SALE }
      it { should eq ".enquire" }
    end

    context "when any other property type" do
      let(:type) { Property::LISTING_TYPE_FOR_RENT }
      it { should eq ".make_a_booking" }
    end
  end

  describe "#search_results_page_type" do
    before do
      expect(controller).to receive(:action_name).and_return action_name
    end

    context "for a property sales action" do
      let(:action_name) { "browse_for_sale" }

      it "returns :sales" do
        expect(search_results_page_type).to eq :sales
      end
    end

    context "for a property rentals action" do
      let(:action_name) { "browse_for_rent" }

      it "returns :rentals" do
        expect(search_results_page_type).to eq :rentals
      end
    end

    context "for any other action" do
      it "returns nil" do
        expect(search_results_page_type).to eq nil
      end
    end
  end
end
