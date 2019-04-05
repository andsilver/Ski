require "rails_helper"
require_relative "property_header_image"

RSpec.describe "properties/show_showcase", type: :view do
  let(:new_development) { false }
  let(:property) do
    FactoryBot.create(
      :property,
      listing_type: Property::LISTING_TYPE_FOR_SALE,
      new_development: new_development
    )
      .decorate
  end
  let(:booking_link_target_ret) { "_blank" }
  let(:booking_url_ret) { "#book" }

  before do
    assign(:property, property)
    allow(view).to receive(:booking_link_target).and_return(booking_link_target_ret)
    allow(view).to receive(:booking_url).with(property).and_return(booking_url_ret)
  end

  it "sets the theme for the property" do
    allow(property).to receive(:theme).and_return "city-breaks"
    render
    expect(view.content_for(:theme)).to eq "city-breaks"
  end

  it_behaves_like "a property header image"

  it "displays address and country" do
    country = FactoryBot.build(:country)
    property.country = country

    render
    expect(response).to have_content(property.address)
    expect(response).to have_content(country)
  end

  it "displays the property description including raw HTML" do
    property.description = '<h1 id="rental">Rental</h1>'

    render
    expect(response).to have_selector "h1#rental"
  end

  context "when new development" do
    let(:new_development) { true }

    it "links to the contact page" do
      render
      expect(response).to have_selector("a[href='#{contact_property_path(property)}']")
    end

    it "does not use booking_url" do
      render
      expect(response).not_to have_selector(".make-a-booking a[href='#{booking_url_ret}']")
    end
  end

  context "when not new development" do
    let(:new_development) { false }

    it "does not link to the contact page" do
      render
      expect(response).not_to have_selector("a[href='#{contact_property_path(property)}']")
    end

    it "uses booking_url helper for the booking link" do
      render
      expect(response).to have_selector(".make-a-booking a[href='#{booking_url_ret}']")
    end
  end

  it "links to the target given by booking_link_target" do
    render
    expect(response).to have_selector("a[target='#{booking_link_target_ret}']")
  end
end
