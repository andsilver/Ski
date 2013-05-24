require 'spec_helper'

describe ResortsController do
  let(:website) { mock_model(Website).as_null_object }
  let(:resort) { mock_model(Resort).as_null_object }

  before do
    Website.stub(:first).and_return(website)
    controller.stub(:admin?).and_return(false)
  end

  describe "GET show" do
    it "finds a resort" do
      Resort.should_receive(:find_by).with(id: '1')
      get :show, id: '1'
    end

    it "assigns @resort" do
      Resort.stub(:find_by).and_return(resort)
      get :show, id: '1'
      expect(assigns[:resort]).to equal(resort)
    end
  end
end
