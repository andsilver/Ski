require 'rails_helper'
require_relative 'property_header_image'

describe 'properties/show_hotel' do
  let(:property) { FactoryGirl.create(:property, listing_type: Property::LISTING_TYPE_HOTEL) }
  let(:hotel_booking_url_ret)   { '#hotel-booking-url' }
  let(:booking_link_target_ret) { '_blank' }

  before do
    assign(:property, property)
    allow(view).to receive(:hotel_booking_url).and_return(hotel_booking_url_ret)
    allow(view).to receive(:booking_link_target).and_return(booking_link_target_ret)
  end

  it 'displays advertising' do
    render
    expect(view.content_for(:advertising)).to be
  end

  it 'sets the theme for the property' do
    allow(property).to receive(:theme).and_return 'city-breaks'
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
    expect(view).to receive(:star_rating).with(3)
    render
  end

  it 'links to the hotel booking URL' do
    render
    expect(response).to have_selector("a[href='#{hotel_booking_url_ret}']")
  end

  it 'links to the target given by booking_link_target' do
    render
    expect(response).to have_selector("a[target='#{booking_link_target_ret}']")
  end
end
