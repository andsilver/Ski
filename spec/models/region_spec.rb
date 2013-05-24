require 'spec_helper'

describe Region do
  describe '#to_s' do
    it "returns the region's name" do
      expect(Region.new(name: 'Lake Como').to_s).to eq 'Lake Como'
    end
  end
end
