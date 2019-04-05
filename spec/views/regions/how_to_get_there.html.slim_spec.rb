require "rails_helper"

describe "regions/how_to_get_there" do
  before do
    assign(:region, FactoryBot.create(:region))
  end

  it "displays the page content" do
    assign(:page_content, "Take the first left")
    render
    expect(rendered).to have_content("Take the first left")
  end
end
