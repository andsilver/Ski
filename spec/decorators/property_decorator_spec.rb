require 'spec_helper'

describe PropertyDecorator do
  describe '#nearest_lift' do
    it 'appends unit to metres_from_lift' do
      expect(Property.new(metres_from_lift: 500).decorate.nearest_lift).to eq '500m'
    end

    it 'returns > 1km for 1001' do
      expect(Property.new(metres_from_lift: 1001).decorate.nearest_lift).to eq '> 1km'
    end
  end
end
