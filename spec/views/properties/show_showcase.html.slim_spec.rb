require 'rails_helper'
require_relative 'property_header_image'

RSpec.describe 'properties/show_showcase', type: :view do
  let(:property) { FactoryGirl.create(:property, listing_type: Property::LISTING_TYPE_FOR_RENT) }

  before do
    assign(:property, property)
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
end
