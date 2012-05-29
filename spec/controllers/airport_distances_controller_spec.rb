require 'spec_helper'

describe AirportDistancesController do
  let(:website) { mock_model(Website).as_null_object }
  let(:current_user) { mock_model(User).as_null_object }

  before do
    Website.stub(:first).and_return(website)
    session[:user] = 1
    User.stub(:find_by_id).and_return(current_user)
  end

  describe 'GET index' do
    it 'finds all airport distances' do
      AirportDistance.should_receive(:all)
      get 'index'
    end

    it 'assigns @airport_distances' do
      pending
    end
  end
end
