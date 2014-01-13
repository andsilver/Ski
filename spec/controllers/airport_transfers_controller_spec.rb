require 'spec_helper'

describe AirportTransfersController do
  let(:website) { mock_model(Website).as_null_object }
  let(:current_user) { mock_model(User).as_null_object }

  before do
    Website.stub(:first).and_return(website)
    session[:user] = 1
    User.stub(:find_by).and_return(current_user)
  end

  describe 'GET index' do
    it "finds the user's transfers" do
      current_user.should_receive(:airport_transfers)
      get 'index'
    end
  end

  describe 'POST create' do
    pending
  end

  describe 'POST results' do
    let(:airport) { FactoryGirl.create(:airport) }
    let(:resort)  { FactoryGirl.create(:resort) }

    it 'should succeed' do
      post :results, airport_transfer_search: { airport_id: airport.id, resort_id: resort.id }
      expect(response).to be_successful
    end
  end
end
