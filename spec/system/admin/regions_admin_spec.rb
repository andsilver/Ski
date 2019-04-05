# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Regions admin", type: :system do
  fixtures :countries, :holiday_types, :regions, :roles, :users, :websites

  scenario "List regions" do
    FactoryBot.create(:region, name: "Alsace")
    sign_in_as_admin
    visit admin_regions_path
    expect(page).to have_content "Alsace"
  end

  scenario "New region" do
    sign_in_as_admin
    visit admin_regions_path
    click_link "New"
    fill_in "Name",   with: "Alsace"
    fill_in "Slug",   with: "alsace"
    select  "France", from: "Country"
    fill_in "Info",   with: "The fifth-smallest of the 27 regions of France"
    check "Visible"
    click_button "Create Region"
    expect(page).to have_content I18n.t("notices.created")
    expect(page).to have_content "Alsace"
  end

  scenario "Edit region" do
    FactoryBot.create(:region, name: "Alsace")
    sign_in_as_admin
    visit admin_regions_path
    click_link "Edit Alsace"
    fill_in "Name", with: "Yorkshire"
    click_button "Update Region"
    expect(page).to have_content I18n.t("notices.saved")
    expect(find_field("Name").value).to eq "Yorkshire"
  end

  scenario "Delete region" do
    FactoryBot.create(:region, name: "Alsace")
    sign_in_as_admin
    visit admin_regions_path
    click_link "Delete Alsace"
    expect(page).to have_content I18n.t("notices.deleted")
    expect(page).not_to have_content "Alsace"
  end

  scenario "Link holiday type" do
    sign_in_as_admin
    visit edit_admin_region_path(regions(:rhone_alpes))
    select "Lakes & Mountains", from: "Holiday type"
    click_button "Link Holiday Type"
    expect(page.find("#holiday-types table")).to have_content("Lakes & Mountains")
  end

  scenario "Unlink holiday type" do
    brochure = regions(:rhone_alpes).holiday_type_brochures.build(holiday_type: holiday_types(:lakes_and_mountains))
    brochure.save
    sign_in_as_admin
    visit edit_admin_region_path(regions(:rhone_alpes))
    within "#holiday-types table" do
      click_link "Delete"
    end
    expect(page).to have_content "Deleted"
    expect(page).not_to have_css("#holiday-types table")
  end
end
