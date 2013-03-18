require 'spec_helper'

describe 'properties/show_pv' do
  it 'displays the booking iframe' do
    property = Property.new
    pv_accommodation = PvAccommodation.new(price_table_url: 'http://example.org')
    assign(:property, property)
    assign(:accommodation, pv_accommodation)
    render
    rendered.should have_selector('iframe#pv-booking[src="http://example.org"]')
  end
end
