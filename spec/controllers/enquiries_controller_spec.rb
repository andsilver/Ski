require 'spec_helper'

describe EnquiriesController do
  let(:website) { mock_model(Website).as_null_object }

  before do
    Website.stub(:first).and_return(website)
  end

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

  describe "POST create" do
    let(:property) { mock_model(Property).as_null_object }
    let(:user) { mock_model(User).as_null_object }

    before do
      Property.stub(:find).and_return(property)
      property.stub(:user).and_return(user)
    end

    it "finds a property" do
      Property.should_receive(:find).with("1")
      post :create, :enquiry => { :property_id => "1" }
    end
  end

  describe "spam protection" do
    describe "POST current_time" do
      let(:time) { Time.mktime(2011) }
      let(:time_to_i) { time.to_i }

      before do
        Time.stub(:now).and_return(time)
      end

      it "sets session[:enquiry_token] with a secretly hashed current time" do
        post :current_time
        session[:enquiry_token].should eq(Digest::SHA1.hexdigest("--#{time_to_i}--#{MySkiChalet::Application.config.secret_token}--"))
      end
    end
  end
end
