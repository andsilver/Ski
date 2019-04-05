# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Currencies admin", type: :system do
  fixtures :countries, :holiday_types, :roles, :users, :websites

  before(:each) do
    Currency.delete_all
  end

  scenario "List currencies" do
    FactoryBot.create(:currency, code: "GBP")
    sign_in_as_admin
    visit admin_currencies_path
    expect(page).to have_content "GBP"
  end

  scenario "New currency" do
    sign_in_as_admin
    visit admin_currencies_path
    click_link "New"
    fill_in "Name",   with: "Pounds Sterling"
    fill_in "Code",   with: "GBP"
    fill_in "Unit",   with: "£"
    fill_in "In euros", with: "1.5"
    check "Unit goes before the number"
    click_button "Create Currency"
    expect(page).to have_content I18n.t("notices.created")
    expect(page).to have_content "GBP"
  end

  scenario "Edit currency" do
    FactoryBot.create(:currency, code: "GBP")
    sign_in_as_admin
    visit admin_currencies_path
    click_link "Edit GBP"
    fill_in "Code", with: "USD"
    click_button "Update Currency"
    expect(page).to have_content I18n.t("notices.saved")
    expect(page).to have_content "USD"
  end
end
