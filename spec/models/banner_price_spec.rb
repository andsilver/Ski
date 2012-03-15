require 'spec_helper'

describe BannerPrice do
  before do
    BannerPrice.create!(:current_banner_number => 100, :price => 20)
  end

  it { should validate_uniqueness_of(:current_banner_number) }
  it { should validate_uniqueness_of(:price) }

  it 'returns the correct price' do
    BannerPrice.create!(:current_banner_number => 1, :price => 60)
    BannerPrice.create!(:current_banner_number => 3, :price => 50)
    BannerPrice.price_for_advert_number(1).should == 60
    BannerPrice.price_for_advert_number(3).should == 50
    BannerPrice.price_for_advert_number(5).should == 50
  end

  it 'raises an error if no valid banner price' do
    lambda { BannerPrice.price_for_advert_number(1) }.should raise_error
  end
end
