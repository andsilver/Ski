require 'rails_helper'

describe AirportTransfersController do
  let(:website) { double(Website).as_null_object }
  let(:current_user) { double(User).as_null_object }

  before do
    allow(Website).to receive(:first).and_return(website)
    allow(controller).to receive(:signed_in?).and_return(true)
    allow(controller).to receive(:current_user).and_return(current_user)
  end

  describe 'GET index' do
    it "finds the user's transfers" do
      expect(current_user).to receive(:airport_transfers)
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
