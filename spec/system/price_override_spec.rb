# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Price Override", type: :system do
  fixtures :categories, :countries, :resorts, :websites

  scenario "Price override shows in basket" do
    user = FactoryBot.create(:user, {apply_price_override: true, price_override: 500})
    sign_in_with(user.email, "secret")
    add_directory_advert_to_basket
    visit "/basket"
    expect(page).to have_content "Price override €500"
  end
end
