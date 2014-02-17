require 'spec_helper'

describe 'properties/contact.html.slim' do
  before do
    assign(:enquiry, Enquiry.new)
  end

  context 'when hotel' do
    before do
      assign(:property, FactoryGirl.build(:property, listing_type: Property::LISTING_TYPE_HOTEL))
    end

    it 'has introduction specific to hotels' do
      render
      expect(rendered).to have_content I18n.t('properties.contact.introduction.hotel')
    end
  end

  context 'when for rent' do
    before do
      assign(:property, FactoryGirl.build(:property, listing_type: Property::LISTING_TYPE_FOR_RENT))
    end

    it 'has a general introduction' do
      render
      expect(rendered).to have_content I18n.t('properties.contact.introduction.general')
    end
  end
end
