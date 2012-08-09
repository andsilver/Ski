require 'spec_helper'

describe AdvertsController do
  let(:website) { mock_model(Website).as_null_object }
  let(:current_user) { mock_model(User).as_null_object }

  before do
    Website.stub(:first).and_return(website)
    session[:user] = 1
    User.stub(:find_by_id).and_return(current_user)
  end

  describe "GET my" do
    before do
      current_user.stub(:windows).and_return([])
    end

    it "collects windows into groups" do
      pending
    end

    it "finds directory adverts belonging to the current user" do
      current_user.should_receive(:directory_adverts)
      get "my"
    end

    it "finds property rentals belonging to the current user" do
      current_user.should_receive(:properties_for_rent)
      get "my"
    end

    it "finds property sales belonging to the current user" do
      current_user.should_receive(:properties_for_sale)
      get "my"
    end

    it "finds hotels belonging to the current user" do
      current_user.should_receive(:hotels)
      get "my"
    end
  end

  describe "GET basket" do
    before do
      current_user.stub(:adverts_in_basket).and_return []
      website.stub(:vat_for).and_return 0
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

  describe "POST update_basket_contents" do
    context "when durations have been updated" do
      it "updates durations" do
        controller.should_receive(:update_durations)
        post :update_basket_contents, :update_durations => "1", :months => {"1" => "1"}
      end
    end

    context "when and advert is removed" do
      it "removes the advert" do
        controller.should_receive(:remove_advert)
        post :update_basket_contents, :remove_advert => {"1" => "1"}
      end
    end
  end

  describe "POST place order" do
    let(:order) { mock_model(Order).as_null_object }

    before do
      website.stub(:vat_for).and_return 0
      current_user.stub(:adverts_in_basket).and_return([])
    end

    context "with adverts in the basket" do
      pending
    end

    it "deletes a previous unpaid order, if any" do
      session[:order_id] = 1
      Order.stub(:find_by_id).and_return(order)
      order.stub(:status).and_return(Order::WAITING_FOR_PAYMENT)
      order.should_receive(:destroy)

      # ignore order creation
      Order.stub(:new).and_return(order)
      order.stub(:save!).and_return(order)

      post :place_order
    end

    it "creates a new order" do
      Order.stub(:new).and_return(order)
      Order.should_receive(:new)

      # ignore saving of the order
      order.stub(:save!).and_return(order)

      post :place_order
    end

    it "copies the user's details to the order" do
      pending
    end
  end
end
