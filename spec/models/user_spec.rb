require 'spec_helper'

describe User do
  fixtures :users

  describe '#empty_windows' do
    it 'returns adverts that are windows' do
      user = users(:alice)
      window_advert = Advert.create!(window: true, user_id: user.id, expires_at: Time.zone.now + 1.hour)
      non_window_advert = Advert.create!(window: false, user_id: user.id, expires_at: Time.zone.now + 1.hour)
      user.empty_windows.should include(window_advert)
      user.empty_windows.should_not include(non_window_advert)
    end

    it 'returns empty windows' do
      user = users(:alice)
      empty_window_advert = Advert.create!(window: true, property_id: nil, user_id: user.id, expires_at: Time.zone.now + 1.hour)
      full_window_advert = Advert.create!(window: true, property_id: 123, user_id: user.id, expires_at: Time.zone.now + 1.hour)
      user.empty_windows.should include(empty_window_advert)
      user.empty_windows.should_not include(full_window_advert)
    end

    it 'returns windows that have not yet expired' do
      user = users(:alice)
      unexpired_window_advert = Advert.create!(window: true, user_id: user.id, expires_at: Time.zone.now + 1.hour)
      expired_window_advert = Advert.create!(window: true, user_id: user.id, expires_at: Time.zone.now - 1.hour)
      user.empty_windows.should include(unexpired_window_advert)
      user.empty_windows.should_not include(expired_window_advert)
    end
  end

  describe "#has_properties_for_rent?" do
    it "returns true when there are one or more properties for rent" do
      user = User.new
      user.stub(:properties_for_rent).and_return([:a_property])
      user.has_properties_for_rent?.should be_true
    end

    it "returns false when there are 0 properties for rent" do
      user = User.new
      user.stub(:properties_for_rent).and_return([])
      user.has_properties_for_rent?.should be_false
    end
  end

  describe "#has_properties_for_sale?" do
    it "returns true when there are one or more properties for sale" do
      user = User.new
      user.stub(:properties_for_sale).and_return([:a_property])
      user.has_properties_for_sale?.should be_true
    end

    it "returns false when there are 0 properties for sale" do
      user = User.new
      user.stub(:properties_for_sale).and_return([])
      user.has_properties_for_sale?.should be_false
    end
  end

  describe 'pays_vat?' do
    let(:uk) { Country.new(in_eu: true, iso_3166_1_alpha_2: 'GB') }
    let(:france) { Country.new(in_eu: true, iso_3166_1_alpha_2: 'FR') }
    let(:us) { Country.new(in_eu: false, iso_3166_1_alpha_2: 'US') }

    it 'returns true if the VAT number is blank and the country is in the EU' do
      user = User.new(vat_number: '')
      user.stub(:billing_country).and_return(uk)
      user.pays_vat?.should be_true
      user.stub(:billing_country).and_return(france)
      user.pays_vat?.should be_true
    end

    it 'returns false if the VAT number is given and the country is in the EU, not UK' do
      user = User.new(vat_number: '123')
      user.stub(:billing_country).and_return(france)
      user.pays_vat?.should be_false
    end

    it 'returns false if the country is not in the EU' do
      user = User.new(vat_number: '')
      user.stub(:billing_country).and_return(us)
      user.pays_vat?.should be_false
      user.vat_number = '123'
      user.pays_vat?.should be_false
    end

    it 'returns true if country is United Kingdom' do
      user = User.new(vat_number: '')
      user.stub(:billing_country).and_return(uk)
      user.pays_vat?.should be_true
      user.vat_number = '123'
      user.pays_vat?.should be_true
    end
  end
end
