require 'spec_helper'

feature 'Countries' do
  fixtures :countries, :regions, :resorts, :websites

  scenario 'Country page with regions shows a list of regions' do
    visit country_path(countries(:france))
    expect(page).to have_content 'Regions'
    expect(page.find('#links-and-search')).to have_content 'Rhône-Alpes'
  end
end
