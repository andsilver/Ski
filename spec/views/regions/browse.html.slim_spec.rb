require "rails_helper"

RSpec.describe "properties/browse.html.slim", type: :view do
  before do
    assign(:breadcrumbs, {})
    assign(:heading, "heading")
    assign(:search_filters, [])
    assign(:properties, [])
  end

  context "with @region" do
    it "uses the region's theme" do
      ski_region = FactoryBot.build(:region)
      assign(:region, ski_region)
      allow(ski_region).to receive(:theme).and_return "ski"
      render
      expect(view.content_for(:theme)).to eq "ski"
    end
  end
end
