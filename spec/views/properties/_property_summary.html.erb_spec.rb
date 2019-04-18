require "rails_helper"

RSpec.describe "properties/_property_summary", type: :view do
  include ViewSpecHelpers

  let(:property) { FactoryBot.create(:property, strapline: "strapline").decorate }

  it "includes the resort name (SEO)" do
    property.resort = FactoryBot.create(:resort, name: "Sorrento")
    render "properties/property_summary", p: property
    expect(rendered).to have_content("Sorrento")
  end

  it "includes the property type (SEO)" do
    allow(view).to receive(:property_type).and_return "Castle"
    render "properties/property_summary", p: property
    expect(rendered).to have_content("Castle")
  end

  it "includes the truncated property name in .property-title" do
    truncated = "TRUNCATED"
    allow(property).to receive(:truncated_name).and_return(truncated)
    render "properties/property_summary", p: property
    within(".property-title") do |psd|
      expect(psd).to have_content(truncated)
    end
  end

  it "uses the strapline for a description" do
    render "properties/property_summary", p: property
    within(".property-block-details-description") do |description|
      expect(description).to have_content("strapline")
    end
  end

  context "when for rent" do
    before do
      property.listing_type = Property::LISTING_TYPE_FOR_RENT
      property.weekly_rent_price = 1500
      property.sleeping_capacity = 8
    end

    it "displays weekly rent price" do
      render "properties/property_summary", p: property
      within ".property-block-details-price" do |price|
        expect(price).to have_content I18n.t("properties.property_summary.weekly_price", price: "#{property.currency.unit}1,500")
      end
    end

    it "displays sleeping capacity" do
      render "properties/property_summary", p: property
      expect(rendered).to have_content("Capacity: 8")
    end
  end

  context "when for sale" do
    before do
      property.listing_type = Property::LISTING_TYPE_FOR_SALE
      property.sale_price = 1_250_000
    end

    it "does not show sleeping capacity" do
      render "properties/property_summary", p: property
      expect(rendered).not_to have_content("Sleeps")
    end
  end
end
