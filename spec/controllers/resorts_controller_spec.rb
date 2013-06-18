require 'spec_helper'

describe ResortsController do
  let(:website) { mock_model(Website).as_null_object }
  let(:resort) { mock_model(Resort).as_null_object }

  before do
    Website.stub(:first).and_return(website)
    controller.stub(:admin?).and_return(false)
  end

  describe 'GET show' do
    it 'finds a resort by its slug' do
      Resort.should_receive(:find_by).with(slug: 'chamonix')
      get :show, id: 'chamonix'
    end

    it 'assigns @resort' do
      Resort.stub(:find_by).and_return(resort)
      get :show, id: 'chamonix'
      expect(assigns[:resort]).to equal(resort)
    end
  end
end
