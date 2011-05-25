require 'spec_helper'

describe ResortsController do
  let(:website) { mock_model(Website).as_null_object }
  let(:resort) { mock_model(Resort).as_null_object }

  before do
    Website.stub(:first).and_return(website)
    controller.stub(:admin?).and_return(true)
  end

  describe "GET index" do
    let(:countries) { mock(Array) }

    before do
      Country.stub(:with_resorts).and_return(countries)
    end

    it "finds all countries with resorts" do
      Country.should_receive(:with_resorts)
      get :index
    end

    it "assigns @countries" do
      get :index
      assigns[:countries].should equal(countries)
    end
  end

  describe "GET show" do
    it "finds a resort" do
      Resort.should_receive(:find_by_id).with("1")
      get :show, :id => "1"
    end

    it "assigns @resort" do
      Resort.stub(:find_by_id).and_return(resort)
      get :show, :id => "1"
      assigns[:resort].should equal(resort)
    end
  end

  describe "DELETE destroy" do
    it "destroys a resort" do
      Resort.stub(:find_by_id).and_return(resort)
      resort.should_receive(:destroy)
      delete :destroy, :id => "1"
    end

    it "redirects to the resorts index" do
      delete :destroy, :id => "1"
      response.should redirect_to(resorts_path)
    end
  end
end
