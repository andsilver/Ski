require 'spec_helper'

describe 'properties/_show_property_heading' do
  it 'shows New Developments in the breadcrumbs for a new development' do
    assign(:property, FactoryGirl.create(:property, listing_type: Property::LISTING_TYPE_FOR_SALE, new_development: true))
    render
    expect(rendered).to have_content 'New Developments'
  end
end
