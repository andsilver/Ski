require 'spec_helper'
require_relative 'shared_model_examples'

describe Region do
  it_behaves_like 'a flat namespace slug validator', :region

  describe '#airport_distances' do
    it 'returns airport distances for all child resorts' do
      region = FactoryGirl.create(:region)
      r1 = FactoryGirl.create(:resort, region: region)
      ad1 = FactoryGirl.create(:airport_distance, resort: r1)
      r2 = FactoryGirl.create(:resort, region: region)
      ad2 = FactoryGirl.create(:airport_distance, resort: r2)
      expect(region.airport_distances).to include(ad1)
      expect(region.airport_distances).to include(ad2)
    end
  end

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

  describe '#resort_brochures' do
    let(:ht) { FactoryGirl.create(:holiday_type) }
    let(:region) { FactoryGirl.create(:region) }

    it 'returns brochures for child resorts with specified holiday type' do
      resort = FactoryGirl.create(:resort, region: region)
      region.holiday_type_brochures.build(holiday_type: ht)
      resort_brochure = resort.holiday_type_brochures.build(holiday_type: ht)
      region.save
      resort.save

      region.resort_brochures(ht.id).to_a.should eq [resort_brochure]
    end

    it 'excludes invisible resorts' do
      resort = FactoryGirl.create(:resort, region: region, visible: false)
      region.holiday_type_brochures.build(holiday_type: ht)
      resort_brochure = resort.holiday_type_brochures.build(holiday_type: ht)
      region.save
      resort.save

      region.resort_brochures(ht.id).to_a.should eq []
    end
  end
end
