require 'spec_helper'

describe EnquiriesController do
  describe "GET my" do
    context "when signed in" do
      let(:current_user) { mock_model(User).as_null_object }

      before do
        session[:user] = 1
        User.stub(:find_by_id).and_return(current_user)
      end

      it "finds enquiries belonging to the current user" do
        current_user.should_receive(:enquiries)
        get :my
      end

      it "assigns @enquiries" do
        get :my
        assigns[:enquiries].should_not be_nil
      end
    end

    context "when not signed in" do
      it "redirects to the sign in page" do
        get :my
        response.should redirect_to(sign_in_path)
      end
    end
  end
end
