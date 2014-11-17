require 'rails_helper'

describe Admin::BannerPricesController do
  let(:website) { FactoryGirl.build(:website) }

  before do
    allow(Website).to receive(:first).and_return(website)
  end

  context 'when signed in as admin' do
    before do
      allow(controller).to receive(:admin?).and_return(true)
    end

    describe 'GET index' do
      it 'finds all banner prices' do
        expect(BannerPrice).to receive(:all)
        get 'index'
      end

      it 'assigns @banner_prices' do
        banner_prices = [BannerPrice.new]
        allow(BannerPrice).to receive(:all).and_return(banner_prices)
        get 'index'
        expect(assigns(:banner_prices)).to eq(banner_prices)
      end
    end

    describe 'GET new' do
      it 'instantiates a new banner price' do
        expect(BannerPrice).to receive(:new)
        get 'new'
      end

      it 'assigns @banner_price' do
        banner_price = BannerPrice.new(price: 10)
        allow(BannerPrice).to receive(:new).and_return(banner_price)
        get 'new'
        expect(assigns(:banner_price)).to eq(banner_price)
      end
    end

    describe 'POST create' do
      let(:banner_price) { double(BannerPrice).as_null_object }
      let(:params) { { banner_price: { 'current_banner_number' => '1', 'price' => '10'} } }

      before do
        allow(BannerPrice).to receive(:new).and_return(banner_price)
      end

      it 'instantiates a new banner price with the given params' do
        expect(BannerPrice).to receive(:new).with(params[:banner_price])
        post 'create', params
      end

      context 'when the banner price saves successfully' do
        before do
          allow(banner_price).to receive(:save).and_return(true)
        end

        it 'sets a flash[:notice] message' do
          post 'create', params
          expect(flash[:notice]).to eq("Created.")
        end

        it 'redirects to the banner prices page' do
          post 'create', params
          expect(response).to redirect_to(admin_banner_prices_path)
        end
      end

      context 'when the banner price fails to save' do
        before do
          allow(banner_price).to receive(:save).and_return(false)
        end

        it 'assigns @banner_price' do
          post 'create', params
          expect(assigns(:banner_price)).to eq(banner_price)
        end

        it 'renders the new template' do
          post 'create', params
          expect(response).to render_template('new')
        end
      end
    end

    describe 'GET edit' do
      it 'finds the banner price' do
        expect(BannerPrice).to receive(:find).with('1')
        get 'edit', id: '1'
      end

      it 'assigns @banner_price' do
        bp = BannerPrice.new(price: 20)
        allow(BannerPrice).to receive(:find).with('1').and_return(bp)
        get 'edit', id: '1'
        expect(assigns(:banner_price)).to eq(bp)
      end
    end

    describe 'PUT update' do
      let(:params) { { id: '1', banner_price: { 'current_banner_number' => '1', 'price' => '10'} } }
      let(:banner_price) { double(BannerPrice).as_null_object }

      before do
        allow(BannerPrice).to receive(:find).and_return(banner_price)
      end

      it 'finds the banner price' do
        expect(BannerPrice).to receive(:find).with('1')
        put 'update', params
      end

      context 'when the banner price updates successfully' do
        before do
          allow(banner_price).to receive(:update_attributes).and_return(true)
        end

        it 'redirects to the banner prices page' do
          put 'update', params
          expect(response).to redirect_to(admin_banner_prices_path)
        end

        it 'sets a flash[:notice] message' do          
          put 'update', params
          expect(flash[:notice]).to eq('Saved.')
        end
      end

      context 'when the banner price fails to update' do
        before do
          allow(banner_price).to receive(:update_attributes).and_return(false)
        end

        it 'assigns @banner_price' do
          put 'update', params
          expect(assigns(:banner_price)).to eq(banner_price)
        end

        it 'renders the edit template' do
          put 'update', params
          expect(response).to render_template('edit')
        end
      end
    end

    describe 'DELETE destroy' do
      let(:banner_price) { double(BannerPrice).as_null_object }

      before do
        allow(BannerPrice).to receive(:find).and_return(banner_price)
      end

      it 'finds the banner price' do
        expect(BannerPrice).to receive(:find).with('1')
        delete 'destroy', id: '1'
      end      

      it 'destroys the banner price' do
        expect(banner_price).to receive(:destroy)
        delete 'destroy', id: '1'
      end

      it 'redirects to the banner prices page' do
        delete 'destroy', id: '1'
        expect(response).to redirect_to(admin_banner_prices_path)
      end

      it 'sets a flash[:notice] message' do          
        delete 'destroy', id: '1'
        expect(flash[:notice]).to eq('Deleted.')
      end
    end
  end
end
