require 'rails_helper'

describe BannerPrice do
  before do
    BannerPrice.delete_all
    BannerPrice.create!(current_banner_number: 100, price: 20)
  end

  it { should validate_uniqueness_of(:current_banner_number) }
  it { should validate_uniqueness_of(:price) }

  it 'returns the correct price' do
    BannerPrice.create!(current_banner_number: 1, price: 60)
    BannerPrice.create!(current_banner_number: 3, price: 50)
    expect(BannerPrice.price_for_advert_number(1)).to eq 60
    expect(BannerPrice.price_for_advert_number(3)).to eq 50
    expect(BannerPrice.price_for_advert_number(5)).to eq 50
  end

  it 'raises an error if no valid banner price' do
    expect { BannerPrice.price_for_advert_number(1) }.to raise_error
  end
end
