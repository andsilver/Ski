require 'spec_helper'

describe LateAvailabilityController do
  let(:website) { mock_model(Website).as_null_object }

  before do
    Website.stub(:first).and_return(website)
  end

  describe 'GET index' do
    it 'finds 9 featured late availability properties' do
      finder = mock(LateAvailability::Finder)
      LateAvailability::Finder.should_receive(:new).and_return(finder)
      finder.should_receive(:find_featured).with(limit: 9)
      get 'index'
    end

    it 'assigns @featured_properties' do
      featured = [Property.new]

      finder = mock(LateAvailability::Finder).as_null_object
      LateAvailability::Finder.stub(:new).and_return(finder)
      finder.stub(:find_featured).and_return(featured)
      get 'index'
      assigns(:featured_properties).should eq(featured)
    end
  end
end
