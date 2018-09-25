require 'rails_helper'
require_relative 'property_header_image'

describe 'properties/contact.html.slim' do
  let(:property) { FactoryBot.build(:property) }

  before do
    assign(:enquiry, Enquiry.new)
  end

  it_behaves_like 'a property header image'

  context 'when for rent' do
    before do
      assign(:property, FactoryBot.build(:property, listing_type: Property::LISTING_TYPE_FOR_RENT))
    end

    it 'has a general introduction' do
      render
      expect(rendered).to have_content I18n.t('properties.contact.introduction.general')
    end
  end
end
