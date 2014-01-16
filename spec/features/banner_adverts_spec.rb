require 'spec_helper'

feature 'Banner adverts' do
  fixtures :banner_prices, :categories, :countries, :resorts, :roles, :users, :websites

  scenario 'Create multiple banner adverts' do
    sign_in_as_emily_evans
    add_banner_advert_to_basket(resorts: ['Austria > St Anton', 'France > Chamonix'])
    expect(page).to have_content 'St Anton Banner Advert + Free Directory Advert'
    expect(page).to have_content 'Chamonix Banner Advert + Free Directory Advert'
  end

  scenario 'Handles long straplines gracefully' do
    sign_in_as_emily_evans
    expect{add_banner_advert_to_basket(strapline: 'X' * 256)}.to_not raise_error
    expect(page).to have_content 'Strapline is too long (maximum is 255 characters)'
  end
end
