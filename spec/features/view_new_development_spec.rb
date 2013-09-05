require 'spec_helper'

feature 'View New Development' do
  fixtures :countries, :currencies, :properties, :resorts, :users, :websites

  scenario 'Viewing a new development shows a breadcrumb for new developments' do
    visit property_path(properties(:new_development))
    expect(page.find('.breadcrumb li + li + li a')).to have_content('New Developments')
  end
end
