require "rails_helper"
require "will_paginate/array"

describe "properties/browse" do
  let(:resort) { FactoryBot.create(:resort) }

  before do
    assign(:breadcrumbs, {})
    assign(:properties, [])
    assign(:search_filters, [])
  end

  context "when there are properties and search results page type is :sales" do
    before do
      allow(view).to receive(:search_results_page_type).and_return(:sales)
      assign(:properties, [Property.new(currency: Currency.new)].paginate)
    end

    it "contains a sale price sorting method" do
      render
      expect(rendered)
        .to have_selector 'option[value="normalised_sale_price DESC"]'
    end

    it "contains a number of bathrooms sorting method" do
      render
      expect(rendered).to have_selector 'option[value="number_of_bathrooms ASC"]'
    end
  end

  context "when there are properties and search results page type is :rentals" do
    before do
      allow(view).to receive(:search_results_page_type).and_return(:rentals)
      assign(:properties, [Property.new(currency: Currency.new)].paginate)
    end

    it "contains a rental price sorting method" do
      render
      expect(rendered)
        .to have_selector 'option[value="normalised_weekly_rent_price DESC"]'
    end
  end

  def search
    view.content_for(:search)
  end

  context "with results" do
    before do
      FactoryBot.create(:property)
      @properties = Property.all.paginate(page: 1)
      assign(:properties, @properties)
    end

    it "shows pagination" do
      render
      expect(rendered).to have_selector(".results-count")
    end
  end

  def no_distance_from_lift
    expect(view.content_for(:links_and_search)).not_to have_content(t("properties.browse.distance_from_lift"))
  end
end
