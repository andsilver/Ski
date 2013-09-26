require 'spec_helper'

describe 'properties/show_pv' do
  it 'displays the booking iframe' do
    property = FactoryGirl.create(:property)
    pv_accommodation = PvAccommodation.new(price_table_url: 'http://example.org')
    assign(:property, property)
    assign(:accommodation, pv_accommodation)
    assign(:breadcrumbs, {})
    render
    expect(rendered).to have_selector('iframe#pv-booking[src="http://example.org"]')
  end
end
