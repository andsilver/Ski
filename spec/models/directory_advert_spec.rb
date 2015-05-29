require 'rails_helper'

RSpec.describe DirectoryAdvert, type: :model do
  describe '#price' do
    context 'when a banner advert' do
      let(:da) { DirectoryAdvert.new {|da| da.is_banner_advert = true} }

      it 'requests the price from BannerPrice' do
        expect(BannerPrice).to receive(:price_for_advert_number).with(3).and_return(10)
        da.price(Advert.new, 3)
      end

      it 'returns the price from BannerPrice multiplied by 100' do
        allow(BannerPrice).to receive(:price_for_advert_number).and_return(10)
        expect(da.price(Advert.new, 3)).to eq 1000
      end
    end
  end

  describe '#clicks' do
    it 'returns :click TrackedActions' do
      da = FactoryGirl.create(:directory_advert)
      3.times { TrackedAction.create(
        action_type: :click,
        trackable_id: da.id,
        trackable_type: 'DirectoryAdvert'
      ) }
      expect(da.reload.clicks.count).to eq 3
    end
  end

  describe '.small_banners_for' do
    context 'with a region' do
      it 'returns an empty array' do
        expect(DirectoryAdvert.small_banners_for(Region.new)).to eq []
      end

      it 'does not call self.banner_adverts_for' do
        expect(DirectoryAdvert).not_to receive(:banner_adverts_for)
        DirectoryAdvert.small_banners_for(Region.new)
      end
    end

    context 'with a resort' do
      it 'calls self.banner_adverts_for' do
        expect(DirectoryAdvert).to receive(:banner_adverts_for)
        DirectoryAdvert.small_banners_for(Resort.new)
      end
    end
  end
end
