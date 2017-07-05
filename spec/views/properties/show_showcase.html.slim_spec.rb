require 'rails_helper'
require_relative 'property_header_image'

RSpec.describe 'properties/show_showcase', type: :view do
  let(:property) { FactoryGirl.create(:property, listing_type: Property::LISTING_TYPE_FOR_RENT) }
  let(:booking_link_target_ret) { '_blank' }

  before do
    assign(:property, property)
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

  it 'displays the property description including raw HTML' do
    property.description = '<h1 id="rental">Rental</h1>'

    render
    expect(response).to have_selector 'h1#rental'
  end

  it 'displays star rating' do
    property.star_rating = 3
    expect(view).to receive(:star_rating).with(3)
    render
  end

  it 'uses booking_url helper for the booking link' do
    allow(view)
      .to receive(:booking_url).with(property).and_return 'http://example.org'
    render
    expect(response).to have_selector(".make-a-booking a[href='http://example.org']")
  end

  it 'links to the target given by booking_link_target' do
    render
    expect(response).to have_selector("a[target='#{booking_link_target_ret}']")
  end
end
