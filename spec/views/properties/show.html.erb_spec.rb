require 'spec_helper'

describe 'properties/show' do
  it 'shows a table of features' do
    assign(:property, FactoryGirl.create(:property).decorate)
    render
    expect(rendered).to have_selector('#features')
  end

  context 'when a hotel' do
    it 'does not show a table of features' do
      assign(:property, FactoryGirl.create(:property, listing_type: Property::LISTING_TYPE_HOTEL).decorate)
      render
      expect(rendered).not_to have_selector('#features')
    end
  end
end
