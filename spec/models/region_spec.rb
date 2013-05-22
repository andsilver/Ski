require 'spec_helper'

describe Region do
  describe '#to_s' do
    it "returns the region's name" do
      expect(Region.new(name: 'Bellagio').to_s).to eq 'Bellagio'
    end
  end
end
