require 'spec_helper'

describe Denormalize do
  describe '.denormalize' do
    before { Currency.stub(:update_exchange_rates) }

    it 'updates featured properties' do
      Denormalize.should_receive(:update_featured_properties)
      Denormalize.denormalize
    end

    it 'updates exchange rates' do
      Currency.should_receive(:update_exchange_rates)
      Denormalize.denormalize
    end

    it 'updates properties' do
      Denormalize.should_receive(:update_properties)
      Denormalize.denormalize
    end

    it 'updates resorts' do
      Denormalize.should_receive(:update_resorts)
      Denormalize.denormalize
    end

    it 'updates countries' do
      Denormalize.should_receive(:update_countries)
      Denormalize.denormalize
    end

    it 'updates regions' do
      Denormalize.should_receive(:update_regions)
      Denormalize.denormalize
    end
  end

  describe '.update_featured_properties' do
    context 'without a website' do
      it 'does not raise' do
        expect{Denormalize.update_featured_properties}.not_to raise_error
      end
    end

    context 'with a website' do
      let!(:website) { Website.first || FactoryGirl.create(:website) }

      it 'assigns featured properties to the website' do
        featured_properties = [FactoryGirl.create(:property)]
        Property.should_receive(:featured).and_return featured_properties
        Denormalize.update_featured_properties
        website.reload
        website.featured_properties.should eq featured_properties
      end
    end
  end

  describe '.update_properties' do
    it 'suspends geocoding' do
      Property.should_receive(:stop_geocoding)
      Property.should_receive(:resume_geocoding)
      Denormalize.update_properties
    end
  end
end
