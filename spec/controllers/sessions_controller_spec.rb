require 'spec_helper'

describe SessionsController do
  let(:website) { mock_model(Website).as_null_object }

  before do
    Website.stub(:first).and_return(website)
  end

  describe "GET new" do
    it "does nothing" do
    end
  end

  describe "POST create" do
    let(:user) { mock_model(User).as_null_object }

    it "authenticates the user" do
      User.should_receive(:authenticate).with("email", "password")
      post :create, { :email => "email", :password => "password" }
    end

    context "when authentication is successful" do
      before do
        User.stub(:authenticate).and_return(user)
        user.stub(:id).and_return(123)
      end

      it "sets session[:user]" do
        post :create
        session[:user].should eq(user.id)
      end

      it "welcomes the user back" do
        post :create
        flash[:notice].should =~ /Welcome back, /
      end

      it "redirects to the advertise page" do
        post :create
        response.should redirect_to advertise_path
      end
    end

    context "when authentication is unsuccessful" do
      before do
        User.stub(:authenticate).and_return(nil)
      end

      it "informs the user" do
        post :create
        flash[:notice].should =~ /Your sign in attempt failed/
      end

      it "redirects to the sign in page" do
        post :create
        response.should redirect_to sign_in_path
      end
    end
  end

  describe "DELETE destroy" do
    it "resets the session" do
      controller.should_receive(:reset_session)
      delete :destroy
    end

    it "redirects to the home page" do
      delete :destroy
      response.should redirect_to root_path
    end
  end
end
