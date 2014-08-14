require 'rails_helper'

feature 'View New Development' do
  fixtures :websites

  let(:new_development) { FactoryGirl.create(:property, listing_type: Property::LISTING_TYPE_FOR_SALE, new_development: true) }

  scenario 'Viewing a new development shows a breadcrumb for new developments' do
    visit property_path(new_development)
    expect(page.find('.breadcrumb li + li a')).to have_content(I18n.t('new_developments'))
  end
end
