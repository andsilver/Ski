require 'spec_helper'
require_relative 'property_header_image'

describe 'properties/show_new_development' do
  let(:property) { FactoryGirl.create(:property, new_development: true).decorate }

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

  it_behaves_like 'a property header image'

  it 'displays address and country' do
    country = FactoryGirl.build(:country)
    property.country = country

    render
    expect(response).to have_content(property.address)
    expect(response).to have_content(country)
  end

  it 'displays the new development including raw HTML' do
    property.description = '<h1 id="newdev">New Development</h1>'

    render
    expect(response).to have_selector 'h1#newdev'
  end

  it 'links to the contact page' do
    render
    expect(response).to have_selector("a[href='#{contact_property_path(property)}']")
  end
end
