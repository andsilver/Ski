require 'rails_helper'

describe DirectoryAdvert do
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
end
