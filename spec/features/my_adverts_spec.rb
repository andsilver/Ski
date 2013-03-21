require 'spec_helper'

feature 'My Adverts' do
  fixtures :categories, :countries, :resorts, :roles, :users, :websites

  scenario 'Delete all new adverts' do
    sign_in_as_emily_evans
    add_banner_advert_to_basket
    visit '/my/adverts'
    page.should have_content 'Directory and Banner Adverts'
    click_button 'Delete all new adverts'
    page.should have_content 'All new adverts have been deleted.'
    page.should_not have_content 'Directory and Banner Adverts'
  end
end
