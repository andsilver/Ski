require 'spec_helper'

feature 'Regions admin' do
  fixtures :countries, :regions, :roles, :users, :websites

  scenario 'List regions' do
    FactoryGirl.create(:region, name: 'Alsace')
    sign_in_as_admin
    visit admin_regions_path
    expect(page).to have_content 'Alsace'
  end

  scenario 'New region' do
    sign_in_as_admin
    visit admin_regions_path
    click_link 'New'
    fill_in 'Name',   with: 'Alsace'
    select  'France', from: 'Country'
    fill_in 'Info',   with: 'The fifth-smallest of the 27 regions of France'
    click_button 'Create Region'
    expect(page).to have_content I18n.t('notices.created')
    expect(page).to have_content 'Alsace'
  end

  scenario 'Edit region' do
    FactoryGirl.create(:region, name: 'Alsace')
    sign_in_as_admin
    visit admin_regions_path
    click_link 'Edit Alsace'
    fill_in 'Name', with: 'Yorkshire'
    click_button 'Update Region'
    expect(page).to have_content I18n.t('notices.saved')
    expect(page).to have_content 'Yorkshire'
  end

  scenario 'Delete region' do
    FactoryGirl.create(:region, name: 'Alsace')
    sign_in_as_admin
    visit admin_regions_path
    click_link 'Delete Alsace'
    expect(page).to have_content I18n.t('notices.deleted')
    expect(page).not_to have_content 'Alsace'
  end
end
