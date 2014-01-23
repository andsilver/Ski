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

  it 'sets the theme for the property' do
    property.stub(:theme).and_return 'city-breaks'
    render
    expect(view.content_for(:theme)).to eq 'city-breaks'
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

    it 'shows the property name in the header title' do
      render
      within('p.header-title') do |header_title|
        expect(header_title).to have_content property.name
      end
    end
  end

  it 'displays address and country' do
    country = FactoryGirl.build(:country)
    property.country = country

    render
    expect(response).to have_content(property.address)
    expect(response).to have_content(country)
  end

  it 'displays the hotel description including raw HTML' do
    property.description = '<h1 id="hotel">Hotel</h1>'

    render
    expect(response).to have_selector 'h1#hotel'
  end
end
