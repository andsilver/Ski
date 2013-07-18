require 'spec_helper'

describe RegionsController do
  let(:website) { mock_model(Website).as_null_object }
  let(:region) { mock_model(Region).as_null_object }

  before do
    Website.stub(:first).and_return(website)
    controller.stub(:admin?).and_return(false)
  end

  describe 'GET show' do
    it 'finds a region by its slug' do
      Region.should_receive(:find_by).with(slug: 'lake-como')
      get :show, id: 'lake-como'
    end

    it 'assigns @region' do
      Region.stub(:find_by).and_return(region)
      get :show, id: 'lake-como'
      expect(assigns[:region]).to equal(region)
    end

    context 'when region found' do
      before { Region.stub(:find_by).and_return(region) }

      it 'gets featured properties for the region' do
        region.should_receive(:featured_properties)
        get :show, id: 'lake-como'
      end

      it 'assigns @featured_properties' do
        region.stub(:featured_properties).and_return(:featured_properties)
        get :show, id: 'lake-como'
        expect(assigns(:featured_properties)).to eq :featured_properties
      end
    end

    context 'when region not found' do
      it 'renders 404' do
        get :show, id: 'lake-como'
        expect(response.status).to eq 404
      end
    end
  end
end
