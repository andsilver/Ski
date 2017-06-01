require 'rails_helper'

describe LateAvailabilityController do
  let(:website) { double(Website).as_null_object }

  before do
    allow(Website).to receive(:first).and_return(website)
  end

  describe 'GET index' do
    it 'finds 8 featured late availability properties' do
      finder = double(LateAvailability::Finder)
      expect(LateAvailability::Finder).to receive(:new).and_return(finder)
      expect(finder).to receive(:find_featured).with(limit: 8)
      get 'index'
    end

    it 'assigns @featured_properties' do
      pending
      featured = [Property.new]

      finder = double(LateAvailability::Finder).as_null_object
      allow(LateAvailability::Finder).to receive(:new).and_return(finder)
      allow(finder).to receive(:find_featured).and_return(featured)
      get 'index'
      expect(assigns(:featured_properties)).to eq(featured)
    end
  end
end
