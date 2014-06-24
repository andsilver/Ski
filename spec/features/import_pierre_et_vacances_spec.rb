require 'rails_helper'

feature 'Import Pierre et Vacances' do
  before { setup_website }

  fixtures :countries, :currencies, :roles, :users

  class FakeFTP
    XML_FILENAME = 'pierreetvacances.xml'
    DEST         = "pierreetvacances/#{XML_FILENAME}"
    SRC          = "test-files/#{XML_FILENAME}"

    def get
      FileUtils.rm(DEST) if File.exist? DEST
      FileUtils.cp(SRC, DEST)
    end

    def xml_filename
      XML_FILENAME
    end
  end

  scenario 'Admin import properties' do
    sign_in_as_admin
    setup_pv_user

    PierreEtVacances::FTP.stub(:new).and_return(FakeFTP.new)

    visit '/pv_accommodations'
    click_link 'Import Accommodations'
    expect(page).to have_content 'Pierre et Vacances accommodations have been imported.'
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
    phone: '+44.1234567890',
    description: '',
    role: roles(:estate_agent),
    terms_and_conditions: true)
  end
end
