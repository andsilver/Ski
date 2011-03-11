require 'spec_helper'

describe ResortsController do
  let(:resort) { mock_model(Resort).as_null_object }

  describe "GET index" do
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
end
