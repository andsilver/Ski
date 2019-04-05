# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Regions", type: :system do
  fixtures :websites

  scenario "Region page shows region info" do
    rhone_alpes = FactoryBot.create(:region, info: "Located on the eastern border...")
    visit region_path(rhone_alpes)
    expect(page).to have_content("Located on the eastern border...")
  end

  scenario "Region page with resorts shows a list of resorts" do
    rhone_alpes = FactoryBot.create(:region)
    rhone_alpes.resorts << FactoryBot.create(:resort, name: "Chamonix")

    visit region_path(rhone_alpes)
    expect(page.find(".links")).to have_content "Resorts"
    expect(page.find(".links")).to have_content "Chamonix"
  end
end
