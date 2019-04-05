# frozen_string_literal: true

require "rails_helper"

RSpec.describe "My Adverts", type: :system do
  fixtures :categories, :countries, :resorts, :roles, :users, :websites

  scenario "Delete all new adverts" do
    sign_in_as_emily_evans
    add_directory_advert_to_basket
    visit "/my/adverts"
    expect(page).to have_content "Directory Adverts"
    click_button "Delete all new adverts"
    expect(page).to have_content "All new adverts have been deleted."
    expect(page).not_to have_content "Directory Adverts"
  end
end
