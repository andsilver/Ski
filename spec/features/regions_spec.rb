require 'spec_helper'

feature 'Regions' do
  fixtures :regions, :resorts, :websites

  scenario 'Region page shows region info' do
    visit region_path(regions(:rhone_alpes))
    expect(page).to have_content('Located on the eastern border...')
  end

  scenario 'Region page with resorts shows a list of resorts' do
    visit region_path(regions(:rhone_alpes))
    expect(page.find('#links-and-search')).to have_content 'Resorts'
    expect(page.find('#links-and-search')).to have_content 'Chamonix'
  end
end
