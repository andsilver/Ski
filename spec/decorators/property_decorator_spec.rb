require 'spec_helper'

describe PropertyDecorator do
  describe '#has_more_info_button_on_summary?' do
    it 'returns true for Interhome properties' do
      expect(Property.new(interhome_accommodation_id: 1).decorate.has_more_info_button_on_summary?).to be_true
    end

    it 'returns true for hotels' do
      expect(Property.new(listing_type: Property::LISTING_TYPE_HOTEL).decorate.has_more_info_button_on_summary?).to be_true
    end

    it 'returns false for all other properties' do
      expect(Property.new.decorate.has_more_info_button_on_summary?).to be_false
    end
  end

  describe '#nearest_lift' do
    it 'appends unit to metres_from_lift' do
      expect(Property.new(metres_from_lift: 500).decorate.nearest_lift).to eq '500m'
    end

    it 'returns > 1km for 1001' do
      expect(Property.new(metres_from_lift: 1001).decorate.nearest_lift).to eq '> 1km'
    end
  end
end
