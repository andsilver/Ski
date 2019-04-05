require "rails_helper"

RSpec.describe EnquiriesController, type: :controller do
  let(:website) { double(Website).as_null_object }

  before do
    allow(Website).to receive(:first).and_return(website)
  end

  describe "GET my" do
    context "when signed in" do
      let(:current_user) { double(User).as_null_object }

      before do
        allow(controller).to receive(:signed_in?).and_return(true)
        allow(controller).to receive(:current_user).and_return(current_user)
      end

      it "finds enquiries belonging to the current user" do
        expect(current_user).to receive(:enquiries)
        get :my
      end
    end

    context "when not signed in" do
      it "redirects to the sign in page" do
        get :my
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

  describe "POST create" do
    let(:property) { Property.new }
    let(:user) { User.new }

    before do
      allow(Property).to receive(:find).and_return(property)
      allow(property).to receive(:user).and_return(user)
    end

    it "finds a property" do
      expect(Property).to receive(:find).with("1")
      post :create, params: {enquiry: {property_id: "1"}}
    end
  end

  describe "spam protection" do
    describe "POST current_time" do
      let(:time) { Time.mktime(2011) }
      let(:time_to_i) { time.to_i }

      before do
        allow(Time).to receive(:now).and_return(time)
      end

      it "sets session[:enquiry_token] with a secretly hashed current time" do
        post :current_time
        expect(session[:enquiry_token]).to eq(Digest::SHA1.hexdigest("--#{time_to_i}--#{MySkiChalet::Application.config.secret_token}--"))
      end
    end
  end
end
