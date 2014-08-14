require 'rails_helper'

feature 'Regions' do
  fixtures :websites

  scenario 'Region page shows region info' do
    rhone_alpes = FactoryGirl.create(:region, info: 'Located on the eastern border...')
    visit region_path(rhone_alpes)
    expect(page).to have_content('Located on the eastern border...')
  end

  scenario 'Region page with resorts shows a list of resorts' do
    rhone_alpes = FactoryGirl.create(:region)
    rhone_alpes.resorts << FactoryGirl.create(:resort, name: 'Chamonix')

    visit region_path(rhone_alpes)
    expect(page.find('#links-and-search')).to have_content 'Resorts'
    expect(page.find('#links-and-search')).to have_content 'Chamonix'
  end
end
