require 'spec_helper'
require_relative 'property_header_image'

describe 'properties/show_hotel' do
  let(:property) { FactoryGirl.create(:property, listing_type: Property::LISTING_TYPE_HOTEL) }
  let(:hotel_booking_url) { '#hotel-booking-url' }

  before do
    assign(:property, property)
    view.stub(:hotel_booking_url).and_return(hotel_booking_url)
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

  it_behaves_like 'a property header image'

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

  it 'displays star rating' do
    property.star_rating = 3
    view.should_receive(:star_rating).with(3)
    render
  end

  it 'links to the hotel booking URL' do
    render
    expect(response).to have_selector("a[href='#{hotel_booking_url}']")
  end
end
