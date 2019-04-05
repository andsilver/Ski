# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Holiday types admin", type: :system do
  fixtures :roles, :users, :websites

  scenario "List holiday types" do
    FactoryBot.create(:holiday_type, name: "Cruises")
    sign_in_as_admin
    visit admin_holiday_types_path
    expect(page).to have_content "Cruises"
  end

  scenario "New holiday type" do
    sign_in_as_admin
    visit admin_holiday_types_path
    click_link "New"
    fill_in "Name",   with: "Sailing Holidays"
    fill_in "Slug",   with: "sailing-holidays"
    click_button "Create Holiday type"
    expect(page).to have_content I18n.t("notices.created")
    expect(page).to have_content "Sailing Holidays"
    expect(page).to have_content "sailing-holidays"
  end

  scenario "Edit holiday type" do
    FactoryBot.create(:holiday_type, name: "Cruises")
    sign_in_as_admin
    visit admin_holiday_types_path
    click_link "Edit Cruises"
    fill_in "Name", with: "Safaris"
    click_button "Update Holiday type"
    expect(page).to have_content I18n.t("notices.saved")
    expect(page).to have_content "Safaris"
  end

  scenario "Delete holiday type" do
    FactoryBot.create(:holiday_type, name: "Cruises")
    sign_in_as_admin
    visit admin_holiday_types_path
    click_link "Delete Cruises"
    expect(page).to have_content I18n.t("notices.deleted")
    expect(page).not_to have_content "Cruises"
  end
end
