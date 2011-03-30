require 'spec_helper'

describe AdvertsController do
  let(:current_user) { mock_model(User).as_null_object }

  before do
    session[:user] = 1
    User.stub(:find_by_id).and_return(current_user)
  end

  describe "GET basket" do
    before do
      current_user.stub(:adverts_in_basket).and_return []
    end

    it "finds the adverts in the user's basket" do
      current_user.should_receive(:adverts_in_basket)
      get :basket
    end

    it "assigns @lines" do
      get :basket
      assigns(:lines).should_not be_nil
    end
  end
end
