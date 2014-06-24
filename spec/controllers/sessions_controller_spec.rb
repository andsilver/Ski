require 'rails_helper'

describe SessionsController do
  let(:website) { double(Website).as_null_object }

  before do
    Website.stub(:first).and_return(website)
  end

  describe "GET new" do
    it "does nothing" do
    end
  end

  describe "POST create" do
    let(:user) { double(User).as_null_object }
    let(:role) { double(Role).as_null_object }

    before do
      user.stub(:role).and_return(role)
    end

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
        expect(session[:user]).to eq(user.id)
      end

      it "welcomes the user back" do
        post :create
        expect(flash[:notice]).to match /Welcome back, /
      end

      context "when user is an admin" do
        it "redirects to the cms page" do
          role.stub(:admin?).and_return(true)
          post :create
          expect(response).to redirect_to cms_path
        end
      end

      context "when user is not an admin" do
        it "redirects to the advertise page" do
          role.stub(:admin?).and_return(false)
          post :create
          expect(response).to redirect_to advertise_path
        end
      end
    end

    context "when authentication is unsuccessful" do
      before do
        User.stub(:authenticate).and_return(nil)
      end

      it "informs the user" do
        post :create
        expect(flash[:notice]).to match /Your sign in attempt failed/
      end

      it "redirects to the sign in page" do
        post :create
        expect(response).to redirect_to sign_in_path
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
      expect(response).to redirect_to root_path
    end
  end

  describe 'GET switch_user' do
    it 'requires admin' do
      controller.stub(:admin?).and_return(false)
      User.stub(:find).and_return(double(User).as_null_object)
      get 'switch_user', user_id: '1'
      expect(response).to redirect_to sign_in_path
    end
  end
end
