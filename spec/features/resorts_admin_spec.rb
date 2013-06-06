require 'spec_helper'

feature 'Resorts admin' do
  fixtures :countries, :regions, :roles, :users, :websites

  scenario 'Add resort to region from resort page' do
    FactoryGirl.create(:resort, name: 'Bowness-on-Windermere', country: countries(:united_kingdom))
    sign_in_as_admin
    visit admin_resorts_path
    click_link 'Edit Bowness-on-Windermere'
    select 'Lake Windermere', from: 'Region'
    click_button 'Save'
    expect(Resort.find_by(name: 'Bowness-on-Windermere').region.name).to eq 'Lake Windermere'
  end

  scenario 'Edit additional page' do
    bow = FactoryGirl.create(:resort, name: 'Bowness-on-Windermere', country: countries(:united_kingdom))
    sign_in_as_admin
    visit edit_admin_resort_path(bow)
    click_link 'Edit summer-holidays page'
    expect(page).to have_content 'Edit Page'
  end
end
