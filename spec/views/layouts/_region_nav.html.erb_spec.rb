require "rails_helper"

describe "layouts/_region_nav" do
  let(:region) { double(Region).as_null_object }
  before { assign(:region, region) }

  it "displays the region name in a heading" do
    allow(region).to receive(:name).and_return("South Yorkshire")
    render
    expect(Capybara.string(rendered).find("h2")).to have_content("South Yorkshire")
  end

  context "when has how-to-get-there page" do
    before { allow(region).to receive(:has_page?).with("how-to-get-there").and_return(true) }

    it "links to the how-to-get-there page" do
      render
      expect(rendered).to have_content(t("layouts.region_nav.how_to_get_there"))
    end
  end

  context "when does not have a how-to-get-there page" do
    before { allow(region).to receive(:has_page?).with("how-to-get-there").and_return(false) }

    it "does not link to the how-to-get-there page" do
      render
      expect(rendered).not_to have_content(t("layouts.region_nav.how_to_get_there"))
    end
  end
end
