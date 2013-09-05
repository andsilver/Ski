require 'spec_helper'

describe Admin::AirportsController do
  let(:website) { mock_model(Website).as_null_object }
  let(:current_user) { mock_model(User).as_null_object }

  before do
    Website.stub(:first).and_return(website)
    session[:user] = 1
    User.stub(:find_by).and_return(current_user)
  end

  describe 'GET index' do
    it 'finds all airports' do
      pending
    end
  end
end
