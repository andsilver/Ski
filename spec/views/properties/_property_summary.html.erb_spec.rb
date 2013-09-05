require 'spec_helper'

describe 'properties/_property_summary' do
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
end
