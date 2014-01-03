require 'spec_helper'

describe 'properties/show_hotel' do
  include ViewSpecHelpers

  let(:property) { FactoryGirl.create(:property, listing_type: Property::LISTING_TYPE_HOTEL) }

  before do
    assign(:property, property)
  end

  it 'displays advertising' do
    render
    expect(view.content_for(:advertising)).to be
  end

  context 'without an image' do
    before { property.image = nil }

    it 'does not display a header image' do
      render
      expect(response).not_to have_selector('.header-image')
    end
  end

  context 'with an image' do
    before { property.image = FactoryGirl.create(:image) }

    it 'displays the main property image as a header image' do
      render
      within('.header-image') do |header_image|
        expect(header_image).to have_selector 'img'
      end
    end
  end
end
