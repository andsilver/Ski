require 'spec_helper'

describe Region do
  describe '#to_param' do
    it 'returns its slug' do
      expect(Region.new(slug: 'slug').to_param).to eq 'slug'
    end
  end

  describe '#to_s' do
    it "returns the region's name" do
      expect(Region.new(name: 'Lake Como').to_s).to eq 'Lake Como'
    end
  end
end
