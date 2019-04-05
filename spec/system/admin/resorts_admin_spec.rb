# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Resorts admin", type: :system do
  fixtures :countries, :holiday_types, :regions, :roles, :users, :websites

  scenario "Delete a resort" do
    bow
    sign_in_as_admin
    visit admin_resorts_path
    click_link "Delete Bowness-on-Windermere"
    expect(page).to_not have_content "Bowness-on-Windermere"
    expect(page).to have_content "Deleted."
  end

  scenario "Delete a resort with properties" do
    bow
    FactoryBot.create(:property, resort: bow)
    sign_in_as_admin
    visit admin_resorts_path
    click_link "Delete Bowness-on-Windermere"
    expect(page).to have_content I18n.t("admin.resorts.destroy.explanation")
  end

  scenario "Delete properties after deleting resort" do
    bow
    FactoryBot.create(:property, resort: bow)
    sign_in_as_admin
    visit admin_resorts_path
    click_link "Delete Bowness-on-Windermere"
    click_button "Delete Properties"
    expect(bow.properties.any?).to be_falsey
  end

  scenario "Add resort to region from resort page" do
    bow
    sign_in_as_admin
    visit admin_resorts_path
    click_link "Edit Bowness-on-Windermere"
    select "Lake Windermere", from: "Region"
    click_button "Save"
    expect(Resort.find_by(name: "Bowness-on-Windermere").region.name).to eq "Lake Windermere"
  end

  scenario "Edit additional page" do
    bow
    sign_in_as_admin
    visit edit_admin_resort_path(bow)
    click_link "Edit summer-holidays page"
    expect(page).to have_content "Edit Page"
  end

  scenario "Link holiday type" do
    bow
    sign_in_as_admin
    visit edit_admin_resort_path(bow)
    select "Lakes & Mountains", from: "Holiday type"
    click_button "Link Holiday Type"
    expect(page.find("#holiday-types table")).to have_content("Lakes & Mountains")
  end

  scenario "Unlink holiday type" do
    bow
    brochure = bow.holiday_type_brochures.build(holiday_type: holiday_types(:lakes_and_mountains))
    brochure.save
    sign_in_as_admin
    visit edit_admin_resort_path(bow)
    within "#holiday-types table" do
      click_link "Delete"
    end
    expect(page).to have_content "Deleted"
    expect(page).not_to have_css("#holiday-types table")
  end

  def bow
    @bow ||= FactoryBot.create(:resort, name: "Bowness-on-Windermere", country: countries(:united_kingdom))
  end
end
