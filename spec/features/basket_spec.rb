require 'spec_helper'

feature 'Basket' do
  fixtures :banner_prices, :categories, :countries, :resorts, :roles, :users, :websites

  scenario 'Empty basket' do
    sign_in_as_emily_evans
    add_banner_advert_to_basket
    click_button 'Empty Basket'
    page.should have_content 'Your basket is empty.'
  end
end
