require 'spec_helper'

describe 'properties/_property_summary' do
  include ViewSpecHelpers

  let(:property) { FactoryGirl.create(:property, metres_from_lift: 500).decorate }

  context 'when sorting by distance from lift' do
    before { view.stub(:sort_method).and_return 'metres_from_lift ASC' }

    it 'displays distance from lift' do
      render 'properties/property_summary', p: property
      expect(rendered).to have_content('500m')
    end
  end

  context 'when not sorting by distance from lift' do
    it 'does not display distance from lift' do
      render 'properties/property_summary', p: property
      expect(rendered).to_not have_content('500m')
    end
  end

  context 'when for rent' do
    before do
      property.listing_type = Property::LISTING_TYPE_FOR_RENT
      property.weekly_rent_price = 1500
    end

    it 'displays price in the heading' do
      render 'properties/property_summary', p: property
      within 'h3' do |h3|
        expect(h3).to have_content 'Weekly price from 1,500'
      end
    end
  end
end
