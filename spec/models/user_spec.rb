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

  describe '#delete_old_windows' do
    it 'deletes old window adverts' do
      alice = users(:alice)
      old_window = mock_model(Advert, {:old? => true})
      current_window = mock_model(Advert, {:old? => false})

      alice.stub(:windows).and_return [old_window, current_window]

      old_window.should_receive(:delete)
      current_window.should_not_receive(:delete)

      alice.delete_old_windows
    end
  end

  describe '#advertises_through_windows?' do
    it 'returns false if the user has no role' do
      User.new.advertises_through_windows?.should be_false
    end

    it "returns the value of the role's advertises_through_windows?" do
      role = mock_model(Role, :advertises_through_windows? => true)
      user = User.new
      user.stub(:role).and_return(role)
      user.advertises_through_windows?.should be_true
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

  describe '#empty_basket' do
    it 'deletes all adverts in basket' do
      user = User.new
      adverts = []
      adverts.should_receive(:delete_all)
      user.stub(:adverts_in_basket).and_return(adverts)
      user.empty_basket
    end
  end

  describe '#new_advertisables' do
    it 'returns an array of new advertisables' do
      p_new = mock_model(Property, advert_status: :new)
      p_live = mock_model(Property, advert_status: :live)
      d_new = mock_model(DirectoryAdvert, advert_status: :new)
      d_live = mock_model(DirectoryAdvert, advert_status: :live)
      u = User.new
      u.stub(:properties).and_return([p_new, p_live])
      u.stub(:directory_adverts).and_return([d_new, d_live])
      u.new_advertisables.should include(p_new)
      u.new_advertisables.should include(d_new)
      u.new_advertisables.should_not include(p_live)
      u.new_advertisables.should_not include(d_live)
    end
  end

  describe '#remove_expired_coupon' do
    context 'with an expired coupon' do
      let(:coupon) { mock_model(Coupon, :expired? => true) }

      it 'removes it' do
        u = User.new
        u.coupon = coupon
        u.remove_expired_coupon
        u.coupon.should be_nil
      end

      it 'saves' do
        u = User.new
        u.coupon = coupon
        u.should_receive(:save)
        u.remove_expired_coupon
      end
    end

    context 'with an unexpired coupon' do
      let(:coupon) { mock_model(Coupon, :expired? => false) }

      it 'leaves it' do
        u = User.new
        u.coupon = coupon
        u.remove_expired_coupon
        u.coupon.should == coupon
      end

      it 'does not save' do
        u = User.new
        u.coupon = coupon
        u.should_not_receive(:save)
        u.remove_expired_coupon
      end
    end

    context 'with no coupon' do
      it 'does not save' do
        u = User.new
        u.coupon = nil
        u.should_not_receive(:save)
        u.remove_expired_coupon
      end
    end
  end
end
