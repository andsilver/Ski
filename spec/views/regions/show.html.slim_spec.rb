require "rails_helper"

RSpec.describe "regions/show.html.slim" do
  before do
    assign(:featured_properties, [])
  end

  it "shows the home search form" do
    assign(:region, FactoryBot.create(:region))
    assign(:resorts, [])
    render
    expect(view.content_for(:search))
      .to have_selector(".search-form")
  end
end
