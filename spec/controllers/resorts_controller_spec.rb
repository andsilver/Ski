require 'spec_helper'

describe ResortsController do
  let(:resort) { mock_model(Resort).as_null_object }

  before do
    controller.stub(:admin?).and_return(true)
  end

  describe "GET index" do
    let(:resorts) { mock(Array) }

    before do
      Resort.stub(:all).and_return(resorts)
    end

    it "finds all resorts" do
      Resort.should_receive(:all)
      get :index
    end

    it "assigns @resorts" do
      get :index
      assigns[:resorts].should equal(resorts)
    end
  end

  describe "GET info" do
    it "finds a resort" do
      Resort.should_receive(:find_by_id).with("1")
      get :info, :id => "1"
    end

    it "assigns @resort" do
      Resort.stub(:find_by_id).and_return(resort)
      get :info, :id => "1"
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
