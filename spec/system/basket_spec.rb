# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Basket", type: :system do
  fixtures :categories, :countries, :resorts, :roles, :users, :websites

  scenario "Empty basket" do
    sign_in_as_emily_evans
    add_directory_advert_to_basket
    click_button "Empty Basket"
    expect(page).to have_content "Your basket is empty."
  end
end
