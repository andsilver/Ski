require 'rails_helper'

describe 'properties/show_pv' do
  it 'displays the booking iframe' do
    property = FactoryBot.create(:property)
    pv_accommodation = PvAccommodation.new(price_table_url: 'http://example.org')
    assign(:property, property.decorate)
    assign(:accommodation, pv_accommodation)
    render
    expect(rendered).to have_selector('iframe#pv-booking[src="http://example.org"]')
  end
end
