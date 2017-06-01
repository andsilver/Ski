require 'rails_helper'

RSpec.feature 'Quick search' do
  background do
    FactoryGirl.create(:website)
  end

  scenario 'Resort or region is required', js: true do
    visit '/favourites'
    click_button 'Search'
    accept_prompt 'Please choose a resort first.'
  end
end
