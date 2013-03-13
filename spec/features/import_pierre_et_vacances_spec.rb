require 'spec_helper'

feature 'Import Pierre et Vacances' do
  before { setup_website }

  fixtures :countries, :currencies, :roles, :users

  scenario 'Admin import properties' do
    sign_in_as_admin
    setup_pv_user
    visit '/pv_accommodations'
    click_link 'Import Accommodations'
    page.should have_content 'Pierre et Vacances accommodations have been imported.'
  end

  def sign_in_as_admin
    visit '/sign_in'
    fill_in 'Email', with: 'tony@mychaletfinder.com'
    fill_in 'Password', with: 'secret'
    click_button 'Sign In'
  end

  def setup_website
    Website.create!
  end

  def setup_pv_user
    User.create!(
    email: 'pierreetvacances@mychaletfinder.com',
    password: 'secret',
    first_name: 'Pierre',
    last_name: 'et Vacances',
    billing_street: 'Street',
    billing_city: 'City',
    billing_country: countries(:france),
    role: roles(:estate_agent),
    terms_and_conditions: true)
  end
end
