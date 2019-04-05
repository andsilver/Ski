# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Countries admin", type: :system do
  fixtures :countries, :holiday_types, :roles, :users, :websites

  scenario "Link holiday type" do
    sign_in_as_admin
    visit edit_admin_country_path(countries(:united_kingdom))
    select "Lakes & Mountains", from: "Holiday type"
    click_button "Link Holiday Type"
    expect(page.find("#holiday-types table")).to have_content("Lakes & Mountains")
  end

  scenario "Unlink holiday type" do
    brochure = countries(:united_kingdom).holiday_type_brochures.build(holiday_type: holiday_types(:lakes_and_mountains))
    brochure.save
    sign_in_as_admin
    visit edit_admin_country_path(countries(:united_kingdom))
    within "#holiday-types table" do
      click_link "Delete"
    end
    expect(page).to have_content "Deleted"
    expect(page).not_to have_css("#holiday-types table")
  end
end
