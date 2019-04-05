# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Window base prices admin", type: :system do
  fixtures :roles, :users, :websites

  scenario "List window base prices" do
    FactoryBot.create(:window_base_price, price: 95)
    sign_in_as_admin
    visit admin_window_base_prices_path
    expect(page).to have_content "95"
  end

  scenario "New window base price" do
    sign_in_as_admin
    visit admin_window_base_prices_path
    click_link "New"
    fill_in "Quantity",   with: "1234"
    fill_in "Price",      with: "30"
    click_button "Create Window base price"
    expect(page).to have_content I18n.t("notices.created")
    expect(page).to have_content "1234"
  end

  scenario "Edit window base price" do
    wbp = FactoryBot.create(:window_base_price, price: 95)
    sign_in_as_admin
    visit admin_window_base_prices_path
    click_link "Edit #{wbp}"
    fill_in "Price", with: "96"
    click_button "Update Window base price"
    expect(page).to have_content I18n.t("notices.saved")
    expect(page).to have_content "96"
  end
end
