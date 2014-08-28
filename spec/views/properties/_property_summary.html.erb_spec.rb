require 'rails_helper'

describe 'properties/_property_summary' do
  include ViewSpecHelpers

  let(:property) { FactoryGirl.create(:property, metres_from_lift: 500).decorate }

  it 'includes the resort name (SEO)' do
    property.resort = FactoryGirl.create(:resort, name: 'Sorrento')
    render 'properties/property_summary', p: property
    expect(rendered).to have_content('Sorrento')
  end

  it 'includes the property type (SEO)' do
    view.stub(:property_type).and_return 'Castle'
    render 'properties/property_summary', p: property
    expect(rendered).to have_content('Castle')    
  end

  it 'includes the truncated property name in .property-summary-description' do
    truncated = 'TRUNCATED'
    allow(property).to receive(:truncated_name).and_return(truncated)
    render 'properties/property_summary', p: property
    within('.property-summary-description') do |psd|
      expect(psd).to have_content(truncated)
    end
  end

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
      property.sleeping_capacity = 8
    end

    it 'displays price in the heading' do
      render 'properties/property_summary', p: property
      within 'h3' do |h3|
        expect(h3).to have_content I18n.t('properties.property_summary.weekly_price', price: '1,500')
      end
    end

    it 'displays sleeping capacity' do
      render 'properties/property_summary', p: property
      expect(rendered).to have_content('Sleeps 8')
    end
  end

  context 'when for sale' do
    before do
      property.listing_type = Property::LISTING_TYPE_FOR_SALE
      property.sale_price = 1_250_000
    end

    it 'does not show sleeping capacity' do
      render 'properties/property_summary', p: property
      expect(rendered).not_to have_content('Sleeps')
    end
  end
end
