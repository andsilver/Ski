# encoding: utf-8
require 'spec_helper'

feature 'Price Override' do
  fixtures :banner_prices, :categories, :countries, :resorts, :websites

  scenario 'Price override shows in basket' do
    FactoryGirl.create(:user, {apply_price_override: true, price_override: 500})
    sign_in_with('zach.anyman@example.org', 'secret')
    add_banner_advert_to_basket
    visit '/basket'
    page.should have_content 'Price override €500'
  end
end
