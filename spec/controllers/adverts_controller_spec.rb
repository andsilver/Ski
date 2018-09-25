require 'rails_helper'

describe AdvertsController do
  let(:website) { double(Website).as_null_object }
  let(:current_user) { double(User).as_null_object }

  before do
    allow(Website).to receive(:first).and_return(website)
    allow(controller).to receive(:signed_in?).and_return(true)
    allow(controller).to receive(:current_user).and_return(current_user)
  end

  describe 'GET my' do
    before do
      allow(current_user).to receive(:windows).and_return([])
    end

    context 'when the user advertises through windows' do
      before { allow(current_user).to receive(:advertises_through_windows?).and_return(true) }

      it "deletes the user's old windows" do
        expect(current_user).to receive(:delete_old_windows)
        get 'my'
      end

      it 'collects windows into groups' do
        window = double(Advert).as_null_object
        allow(current_user).to receive(:windows).and_return([window, window])
        groups = double(WindowGroups).as_null_object
        allow(WindowGroups).to receive(:new).and_return(groups)
        expect(groups).to receive(:<<).with(window).twice
        get 'my'
      end
    end

    it "finds directory adverts belonging to the current user" do
      expect(current_user).to receive(:directory_adverts)
      get "my"
    end

    it "finds property rentals belonging to the current user" do
      expect(current_user).to receive(:properties_for_rent)
      get "my"
    end

    it "finds property sales belonging to the current user" do
      expect(current_user).to receive(:properties_for_sale)
      get "my"
    end
  end

  describe "GET basket" do
    before do
      allow(current_user).to receive(:adverts_in_basket).and_return []
      allow(current_user).to receive(:apply_price_override?).and_return(false)
      allow(website).to receive(:vat_for).and_return 0
    end

    it "finds the adverts in the user's basket" do
      expect(current_user).to receive(:adverts_in_basket)
      get :basket
    end
  end

  describe "POST update_basket_contents" do
    context "when durations have been updated" do
      it "updates durations" do
        expect(controller).to receive(:update_durations)
        post :update_basket_contents, params: { update_durations: '1', months: {'1' => '1'} }
      end
    end

    context "when and advert is removed" do
      it "removes the advert" do
        expect(controller).to receive(:remove_advert)
        post :update_basket_contents, params: { remove_advert: {'1' => '1'} }
      end
    end

    context 'when the basket is being emptied' do
      it "empties the current user's basket" do
        expect(current_user).to receive(:empty_basket)
        post :update_basket_contents, params: { empty_basket: 'Empty Basket' }
      end

      it 'removes windows from the basket' do
        expect(controller).to receive(:remove_windows_from_basket)
        post :update_basket_contents, params: { empty_basket: 'Empty Basket' }
      end

      it 'tells the user their basket has been emptied' do
        post :update_basket_contents, params: { empty_basket: 'Empty Basket' }
        expect(flash[:notice]).to eq 'Your basket has been emptied.'
      end
    end
  end

  describe "POST place order" do
    let(:order) { double(Order).as_null_object }

    before do
      allow(website).to receive(:vat_for).and_return 0
      allow(current_user).to receive(:adverts_in_basket).and_return([])
      allow(current_user).to receive(:apply_price_override?).and_return(false)
    end

    it "deletes a previous unpaid order, if any" do
      session[:order_id] = 1
      allow(Order).to receive(:find_by).with(id: 1).and_return(order)
      allow(order).to receive(:status).and_return(Order::WAITING_FOR_PAYMENT)
      expect(order).to receive(:destroy)

      # ignore order creation
      allow(Order).to receive(:new).and_return(order)
      allow(order).to receive(:save!).and_return(order)

      post :place_order
    end

    it "creates a new order" do
      allow(Order).to receive(:new).and_return(order)
      expect(Order).to receive(:new)

      # ignore saving of the order
      allow(order).to receive(:save!).and_return(order)

      post :place_order
    end

    it "copies the user's details to the order" do
      allow(Order).to receive(:new).and_return(order)
      expect(controller).to receive(:copy_user_details_to_order)
      post 'place_order'
    end
  end

  describe 'DELETE delete_all_new_advertisables' do
    it 'gets all new adverts from the user' do
      expect(current_user).to receive(:new_advertisables)
      delete 'delete_all_new_advertisables'
    end

    it 'destroys each advertisable' do
      property = double(Property)
      allow(current_user).to receive(:new_advertisables).and_return([property])
      expect(property).to receive(:destroy)
      delete 'delete_all_new_advertisables'
    end

    it 'sets a flash notice' do
      delete 'delete_all_new_advertisables'
      expect(flash[:notice]).to eq 'All new adverts have been deleted.'
    end

    it 'redirects to My Adverts' do
      delete 'delete_all_new_advertisables'
      expect(response).to redirect_to(action: 'my')
    end
  end
end
