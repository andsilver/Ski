require 'spec_helper'

feature 'Regions' do
  fixtures :regions, :websites

  scenario 'Region page shows region info' do
    visit region_path(regions(:rhones_alpes))
    expect(page).to have_content('Located on the eastern border...')
  end
end
