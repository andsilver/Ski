require 'spec_helper'

describe Region do
  describe '#to_param' do
    it 'returns an escaped, URL-friendly param with ID prepended' do
      r = Region.new(name: 'Rhône-Alpes')
      r.stub(:id).and_return(123)
      expect(r.to_param).to eq '123-rhone-alpes'
    end
  end

  describe '#to_s' do
    it "returns the region's name" do
      expect(Region.new(name: 'Lake Como').to_s).to eq 'Lake Como'
    end
  end
end
