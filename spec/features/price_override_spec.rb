# encoding: utf-8
require 'rails_helper'

feature 'Price Override' do
  fixtures :banner_prices, :categories, :countries, :resorts, :websites

  scenario 'Price override shows in basket' do
    user = FactoryGirl.create(:user, {apply_price_override: true, price_override: 500})
    sign_in_with(user.email, 'secret')
    add_banner_advert_to_basket
    visit '/basket'
    expect(page).to have_content 'Price override €500'
  end
end
