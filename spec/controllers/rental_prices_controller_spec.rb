require 'spec_helper'

describe RentalPricesController do
  let(:website) { mock_model(Website).as_null_object }

  before do
    Website.stub(:first).and_return(website)
  end

  describe 'GET results' do
    context 'when params[:rental_prices_search] is missing' do
      it 'redirects to index' do
        get 'results'
        expect(response).to redirect_to(action: 'index')
      end
    end
  end
end
