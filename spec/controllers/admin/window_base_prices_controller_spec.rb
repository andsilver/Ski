require 'rails_helper'

describe Admin::WindowBasePricesController do
  let(:website) { double(Website).as_null_object }

  def mock_window_base_price(stubs = {})
    @mock_window_base_price ||= double(WindowBasePrice, stubs)
  end

  before do
    allow(Website).to receive(:first).and_return(website)
  end

  context 'when signed in as admin' do
    before { signed_in_as_admin }

    describe 'GET index' do
      it 'finds all window base prices ordered by quantity' do
        expect(WindowBasePrice).to receive(:order).with('quantity')
        get 'index'
      end

      it 'assigns @window_base_prices' do
        pending
        allow(WindowBasePrice).to receive(:order).and_return(:window_base_prices)
        get 'index'
        expect(assigns(:window_base_prices)).to eq :window_base_prices
      end
    end

    describe 'GET new' do
      it 'assigns a new instance of WindowBasePrice to @window_base_price' do
        pending
        expect(WindowBasePrice).to receive(:new).and_return(mock_window_base_price)
        get 'new'
        expect(assigns(:window_base_price)).to eq mock_window_base_price
      end
    end

    describe 'POST create' do
      context 'on successful save' do
        before { allow(WindowBasePrice).to receive(:new).and_return(mock_window_base_price(save: true)) }

        it 'redirects to admin window base prices path' do
          post 'create', params: { id: '1', window_base_price: { 'some' => 'params' } }
          expect(response).to redirect_to admin_window_base_prices_path
        end
      end
    end

    describe 'PATCH update' do
      context 'on successful update' do
        before { allow(WindowBasePrice).to receive(:find).and_return(mock_window_base_price(update_attributes: true)) }

        it 'redirects to admin window base prices path' do
          patch 'update', params: { id: '1', window_base_price: { 'some' => 'params' } }
          expect(response).to redirect_to admin_window_base_prices_path
        end
      end
    end

    describe 'DELETE destroy' do
      context 'when window base price found' do
        before { allow(WindowBasePrice).to receive(:find).and_return(mock_window_base_price) }

        it 'destroys the window base price' do
          expect(mock_window_base_price).to receive(:destroy)
          delete 'destroy', params: { id: '1' }
        end

        it 'redirects to admin window base prices path' do
          allow(mock_window_base_price).to receive(:destroy)
          delete 'destroy', params: { id: '1' }
          expect(response).to redirect_to admin_window_base_prices_path
        end
      end
    end
  end
end
