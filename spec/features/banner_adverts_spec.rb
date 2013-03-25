require 'spec_helper'

feature 'Banner adverts' do
  fixtures :banner_prices, :categories, :countries, :resorts, :roles, :users, :websites

  scenario 'Create multiple banner adverts' do
    sign_in_as_emily_evans
    add_banner_advert_to_basket(resorts: ['Austria > St Anton', 'France > Chamonix'])
    page.should have_content 'St Anton Banner Advert + Free Directory Advert'
    page.should have_content 'Chamonix Banner Advert + Free Directory Advert'
  end
end
