require 'rails_helper'

describe Admin::CurrenciesController do
  let(:website) { double(Website).as_null_object }

  before do
    Website.stub(:first).and_return(website)
  end

  def mock_currency(stubs = {})
    @mock_currency ||= double(Currency, stubs)
  end

  context 'when signed in as admin' do
    before { signed_in_as_admin }

    describe 'GET index' do
      it 'assigns all currencies ordered by code to @currencies' do
        currencies = [mock_currency]
        Currency.should_receive(:order).with('code').and_return(currencies)
        get 'index'
        expect(assigns(:currencies)).to eq currencies
      end
    end

    describe 'GET new' do
      it 'assigns a new currency to @currency' do
        Currency.should_receive(:new).and_return(mock_currency)
        get 'new'
        expect(assigns(:currency)).to eq mock_currency
      end
    end

    describe 'POST create' do
      context 'on successful save' do
        before { Currency.stub(:new).and_return(mock_currency(save: true)) }

        it 'redirects to admin currencies path' do
          post 'create', id: '1', currency: { 'some' => 'params' }
          expect(response).to redirect_to admin_currencies_path
        end
      end
    end

    describe 'PATCH update' do
      context 'on successful update' do
        before { Currency.stub(:find).and_return(mock_currency(update_attributes: true)) }

        it 'redirects to admin currencies path' do
          patch 'update', id: '1', currency: { 'some' => 'params' }
          expect(response).to redirect_to admin_currencies_path
        end
      end
    end

    describe 'GET update_exchange_rates' do
      it 'updates exchange rates' do
        Currency.should_receive(:update_exchange_rates)
        get 'update_exchange_rates'
      end

      it 'redirects to admin currencies path' do
        get 'update_exchange_rates'
        expect(response).to redirect_to admin_currencies_path
      end
    end
  end
end
