require 'rails_helper'

RSpec.describe 'Banner prices admin', type: :request do
  before do
    FactoryGirl.create(:website)
    allow_any_instance_of(ApplicationController)
      .to receive(:admin?)
      .and_return(true)
  end

  describe 'GET /admin/banner_prices' do
    it 'lists all banner prices' do
      bp = FactoryGirl.create(
        :banner_price, current_banner_number: 10, price: 95
      )
      get admin_banner_prices_path
      assert_select 'td', text: '10'
      assert_select 'td', text: '95'
    end
  end

  describe 'GET /admin/banner_prices/new' do
    it 'shows a form' do
      get new_admin_banner_price_path
      assert_select "form[action='#{admin_banner_prices_path}']"
    end
  end

  describe 'POST /admin/banner_prices' do
    context 'with valid params' do
      before do
        post(
          admin_banner_prices_path,
          params: {
            banner_price: {
              current_banner_number: '10',
              price: '95'
            }
          }
        )
      end

      it 'creates a new banner price' do
        bp = BannerPrice.last
        expect(bp).to be
        expect(bp.current_banner_number).to eq 10
        expect(bp.price).to eq 95
      end

      it 'redirects to the index' do
        expect(response).to redirect_to(admin_banner_prices_path)
      end

      it 'sets a flash notice' do
        expect(flash[:notice]).to eq I18n.t('notices.created')
      end
    end

    context 'with invalid params' do
      before do
        post(
          admin_banner_prices_path,
          params: {
            banner_price: {
              current_banner_number: '',
              price: '95'
            }
          }
        )
      end

      it 'shows the form again' do
        assert_select "form[action='#{admin_banner_prices_path}']" do
          assert_select "input[name='banner_price[price]'][value='95']"
        end
      end
    end
  end

  describe 'GET /admin/banner_prices/:id/edit' do
    it 'shows a form to edit' do
      bp = FactoryGirl.create(:banner_price)
      get edit_admin_banner_price_path(bp)
      assert_select "form[action='#{admin_banner_price_path(bp)}']"
    end
  end

  describe 'PATCH /admin/banner_prices/:id' do
    context 'with valid params' do
      let(:banner_price) { FactoryGirl.create(:banner_price) }
      before do
        patch(
          admin_banner_price_path(banner_price),
          params: {
            banner_price: {
              current_banner_number: '1',
              price: '10'
            }
          }
        )
      end

      it 'updates the banner price' do
        banner_price.reload
        expect(banner_price.current_banner_number).to eq 1
        expect(banner_price.price).to eq 10
      end

      it 'redirects to the index' do
        expect(response).to redirect_to(admin_banner_prices_path)
      end

      it 'sets a flash notice' do
        expect(flash[:notice]).to eq I18n.t('notices.saved')
      end
    end

    context 'with invalid params' do
      let(:bp) { FactoryGirl.create(:banner_price) }
      before do
        patch(
          admin_banner_price_path(bp),
          params: { banner_price: { current_banner_number: '', price: '10' } }
        )
      end

      it 'shows the form again' do
        assert_select "form[action='#{admin_banner_price_path(bp)}']" do
          assert_select "input[name='banner_price[price]'][value='10']"
        end
      end
    end
  end

  describe 'DELETE /admin/banner_prices/:id' do
    let(:banner_price) { FactoryGirl.create(:banner_price) }
    before { delete admin_banner_price_path(banner_price) }

    it 'deletes the banner price' do
      expect(BannerPrice.exists?(banner_price.id)).to be_falsey
    end

    it 'redirects to the index' do
      expect(response).to redirect_to(admin_banner_prices_path)
    end

    it 'sets a flash notice' do
      expect(flash[:notice]).to eq I18n.t('notices.deleted')
    end
  end
end
