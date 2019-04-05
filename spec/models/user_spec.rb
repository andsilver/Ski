require "rails_helper"

describe User do
  fixtures :users

  describe "#empty_windows" do
    it "returns adverts that are windows" do
      user = users(:alice)
      window_advert = Advert.create!(
        window_spot: true, user_id: user.id, expires_at: Time.zone.now + 1.hour
      )
      non_window_advert = Advert.create!(
        window_spot: false, user_id: user.id, expires_at: Time.zone.now + 1.hour
      )
      expect(user.empty_windows).to include(window_advert)
      expect(user.empty_windows).to_not include(non_window_advert)
    end

    it "returns empty windows" do
      user = users(:alice)
      empty_window_advert = Advert.create!(
        window_spot: true, property_id: nil, user_id: user.id,
        expires_at: Time.zone.now + 1.hour
      )
      full_window_advert = Advert.create!(
        window_spot: true, property_id: 123, user_id: user.id,
        expires_at: Time.zone.now + 1.hour
      )
      expect(user.empty_windows).to include(empty_window_advert)
      expect(user.empty_windows).to_not include(full_window_advert)
    end

    it "returns windows that have not yet expired" do
      user = users(:alice)
      unexpired_window_advert = Advert.create!(
        window_spot: true, user_id: user.id, expires_at: Time.zone.now + 1.hour
      )
      expired_window_advert = Advert.create!(
        window_spot: true, user_id: user.id, expires_at: Time.zone.now - 1.hour
      )
      expect(user.empty_windows).to include(unexpired_window_advert)
      expect(user.empty_windows).to_not include(expired_window_advert)
    end
  end

  describe "#delete_old_windows" do
    it "deletes old window adverts" do
      alice = users(:alice)
      old_window = double(Advert, {old?: true})
      current_window = double(Advert, {old?: false})

      allow(alice).to receive(:windows).and_return [old_window, current_window]

      expect(old_window).to receive(:delete)
      expect(current_window).not_to receive(:delete)

      alice.delete_old_windows
    end
  end

  describe "#advertises_through_windows?" do
    it "returns false if the user has no role" do
      expect(User.new.advertises_through_windows?).to be_falsey
    end

    it "returns the value of the role's advertises_through_windows?" do
      role = double(Role, advertises_through_windows?: true)
      user = User.new
      allow(user).to receive(:role).and_return(role)
      expect(user.advertises_through_windows?).to be_truthy
    end
  end

  describe "#has_properties_for_rent?" do
    it "returns true when there are one or more properties for rent" do
      user = User.new
      allow(user).to receive(:properties_for_rent).and_return([:a_property])
      expect(user.has_properties_for_rent?).to be_truthy
    end

    it "returns false when there are 0 properties for rent" do
      user = User.new
      allow(user).to receive(:properties_for_rent).and_return([])
      expect(user.has_properties_for_rent?).to be_falsey
    end
  end

  describe "#has_properties_for_sale?" do
    it "returns true when there are one or more properties for sale" do
      user = User.new
      allow(user).to receive(:properties_for_sale).and_return([:a_property])
      expect(user.has_properties_for_sale?).to be_truthy
    end

    it "returns false when there are 0 properties for sale" do
      user = User.new
      allow(user).to receive(:properties_for_sale).and_return([])
      expect(user.has_properties_for_sale?).to be_falsey
    end
  end

  # These specs purposely integrate with #country_for_checking_vat instead
  # of stubbing it.
  describe "pays_vat?" do
    let(:uk) { Country.new(in_eu: true, iso_3166_1_alpha_2: "GB") }
    let(:france) { Country.new(in_eu: true, iso_3166_1_alpha_2: "FR") }
    let(:us) { Country.new(in_eu: false, iso_3166_1_alpha_2: "US") }

    it "returns true if the VAT number is blank and the country is in the EU" do
      user = User.new(vat_number: "")
      allow(user).to receive(:billing_country).and_return(uk)
      expect(user.pays_vat?).to be_truthy
      allow(user).to receive(:billing_country).and_return(france)
      expect(user.pays_vat?).to be_truthy
    end

    it "returns false if the VAT number is given and the country is in the EU, not UK" do
      user = User.new(vat_number: "123")
      allow(user).to receive(:billing_country).and_return(france)
      expect(user.pays_vat?).to be_falsey
    end

    it "returns false if the country is not in the EU" do
      user = User.new(vat_number: "")
      allow(user).to receive(:billing_country).and_return(us)
      expect(user.pays_vat?).to be_falsey
      user.vat_number = "123"
      expect(user.pays_vat?).to be_falsey
    end

    it "returns true if country is United Kingdom" do
      user = User.new(vat_number: "")
      allow(user).to receive(:billing_country).and_return(uk)
      expect(user.pays_vat?).to be_truthy
      user.vat_number = "123"
      expect(user.pays_vat?).to be_truthy
    end

    it "returns false if billing country is UK but VAT country is France" do
      user = User.new(vat_number: "123")
      allow(user).to receive(:billing_country).and_return(uk)
      allow(user).to receive(:vat_country).and_return(france)
      expect(user.pays_vat?).to be_falsey
    end

    it "returns true if billing country is US but VAT country is UK" do
      user = User.new(vat_number: "123")
      allow(user).to receive(:billing_country).and_return(us)
      allow(user).to receive(:vat_country).and_return(uk)
      expect(user.pays_vat?).to be_truthy
    end
  end

  describe "#country_for_checking_vat" do
    let(:uk) { Country.new(in_eu: true, iso_3166_1_alpha_2: "GB") }
    let(:france) { Country.new(in_eu: true, iso_3166_1_alpha_2: "FR") }

    it "returns vat_country if not nil" do
      user = User.new(vat_country: uk, billing_country: france)
      expect(user.country_for_checking_vat).to eq uk
    end

    it "returns billing_country if vat_country is nil" do
      user = User.new(vat_country: nil, billing_country: france)
      expect(user.country_for_checking_vat).to eq france
    end
  end

  describe "#empty_basket" do
    it "deletes all adverts in basket" do
      user = User.new
      advert = double(Advert)
      expect(advert).to receive(:delete)
      adverts = [advert]
      allow(user).to receive(:adverts_in_basket).and_return(adverts)
      user.empty_basket
    end
  end

  describe "#new_advertisables" do
    it "returns an array of new advertisables" do
      p_new = double(Property, advert_status: :new)
      p_live = double(Property, advert_status: :live)
      d_new = double(DirectoryAdvert, advert_status: :new)
      d_live = double(DirectoryAdvert, advert_status: :live)
      u = User.new
      allow(u).to receive(:properties).and_return([p_new, p_live])
      allow(u).to receive(:directory_adverts).and_return([d_new, d_live])
      expect(u.new_advertisables).to include(p_new)
      expect(u.new_advertisables).to include(d_new)
      expect(u.new_advertisables).to_not include(p_live)
      expect(u.new_advertisables).to_not include(d_live)
    end
  end

  describe "#remove_expired_coupon" do
    let(:coupon) do
      c = Coupon.new
      allow(c).to receive(:expired?).and_return(expired)
      c
    end

    context "with an expired coupon" do
      let(:expired) { true }

      it "removes it" do
        u = User.new
        u.coupon = coupon
        u.remove_expired_coupon
        expect(u.coupon).to be_nil
      end

      it "saves" do
        u = User.new
        u.coupon = coupon
        expect(u).to receive(:save)
        u.remove_expired_coupon
      end
    end

    context "with an unexpired coupon" do
      let(:expired) { false }

      it "leaves it" do
        u = User.new
        u.coupon = coupon
        u.remove_expired_coupon
        expect(u.coupon).to equal coupon
      end

      it "does not save" do
        u = User.new
        u.coupon = coupon
        expect(u).not_to receive(:save)
        u.remove_expired_coupon
      end
    end

    context "with no coupon" do
      it "does not save" do
        u = User.new
        u.coupon = nil
        expect(u).not_to receive(:save)
        u.remove_expired_coupon
      end
    end
  end
end
