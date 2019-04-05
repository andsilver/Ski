require "rails_helper"

RSpec.describe Advert, type: :model do
  describe ".create_for" do
    let(:property) { Property.new }

    context "when the basket contains the object" do
      it "does not create a new advert" do
        allow(Advert).to receive(:basket_contains?).and_return(true)
        expect(Advert).not_to receive(:new_for)
        Advert.create_for(property)
      end
    end

    context "when the basket does not contain the object" do
      let(:advert) { double(Advert).as_null_object }

      before do
        allow(Advert).to receive(:basket_contains?).and_return(false)
      end

      it "creates a new advert" do
        expect(Advert).to receive(:new_for).with(property).and_return(advert)
        Advert.create_for(property)
      end

      it "sets the advert's duration to the default months of the object" do
        allow(Advert).to receive(:new_for).and_return(advert)
        allow(advert).to receive(:save!).and_return(true)

        allow(property).to receive(:default_months).and_return(24)
        expect(advert).to receive(:months=).with(24)
        Advert.create_for(property)
      end
    end
  end

  describe ".basket_contains?" do
    it "returns true if advert of the same type and id exists in basket" do
      ad = Advert.new(id: 1, directory_advert_id: 123)
      da1 = DirectoryAdvert.new(id: 123)
      allow(ad).to receive(:directory_advert).and_return(da1)
      user = User.new(first_name: "x")
      allow(user).to receive(:adverts_in_basket).and_return([ad])
      da2 = DirectoryAdvert.new(id: 123, user: user)
      expect(Advert.basket_contains?(da2)).to be_truthy
    end

    it "returns false if advert of different type, same id exists in basket" do
      ad = Advert.new(id: 1, property_id: 123)
      prop = Property.new(id: 123)
      allow(ad).to receive(:property).and_return(prop)
      user = User.new(first_name: "x")
      allow(user).to receive(:adverts_in_basket).and_return([ad])
      da = DirectoryAdvert.new(id: 123, user: user)
      expect(Advert.basket_contains?(da)).to be_falsey
    end
  end

  describe ".new_for" do
    it "returns an Advert" do
      expect(Advert.new_for(Property.new({user_id: 1})).is_a?(Advert)).to be_truthy
    end
  end

  describe ".assign_window_for" do
    pending
  end

  describe ".activate_windows_for_user" do
    pending
  end

  describe "#expired?" do
    it "returns true when expired_at is earlier than the current time" do
      a = valid_advert
      a.expires_at = Time.now - 1.minute
      expect(a.expired?).to be_truthy
    end

    it "returns false expired_at is later than the current time" do
      a = valid_advert
      a.expires_at = Time.now + 1.minute
      expect(a.expired?).to be_falsey
    end
  end

  describe "#type" do
    pending
  end

  describe "#virtual_type" do
    it "returns :property when the object is a Property" do
      a = valid_advert
      a.property = Property.new
      expect(a.virtual_type).to eq(:property)
    end

    it "returns :directory_advert when the object is a DirectoryAdvert" do
      a = valid_advert
      a.directory_advert = DirectoryAdvert.new
      expect(a.virtual_type).to eq(:directory_advert)
    end

    it "returns nil when none of the above apply" do
      a = valid_advert
      expect(a.virtual_type).to be_nil
    end
  end

  describe "#object" do
    pending
  end

  describe "#to_s" do
    context "when it has an object" do
      let(:property) { double(Property).as_null_object }
      let(:resort) { double(Resort).as_null_object }

      it "returns a string containing the object's name, resort and type description" do
        a = valid_advert
        allow(a).to receive(:object).and_return(property)
        allow(property).to receive(:name).and_return("My Chalet")
        allow(property).to receive(:resort).and_return(resort)
        allow(resort).to receive(:name).and_return("Chamonix")
        allow(property).to receive(:basket_advert_type_description).and_return("Property")
        expect(a.to_s).to eq "My Chalet (Chamonix Property)"
      end
    end

    context "when it has no object" do
      it "returns to_s from its superclass" do
        a = valid_advert
        expect(a.to_s[0..8]).to eq "#<Advert:"
      end
    end
  end

  describe "#price" do
    context "when it has an object" do
      let(:property) { double(Property).as_null_object }

      it "returns the object's price" do
        price_of_property = 99
        a = valid_advert
        allow(a).to receive(:object).and_return(property)
        expect(property).to receive(:price).with(a, 1).and_return(price_of_property)
        expect(a.price(1)).to equal(price_of_property)
      end
    end

    context "when it has no object" do
      it "returns 0" do
        a = valid_advert
        expect(a.price(1)).to equal(0)
      end
    end
  end

  describe "#start_and_save!" do
    pending
  end

  describe "#days" do
    subject { Advert.new(months: months).days }

    context "for 1 month" do
      let(:months) { 1 }
      it { should eq 31.days }
    end

    context "for 12 months" do
      let(:months) { 12 }
      it { should eq 366.days }
    end
  end

  describe "#record_view" do
    it "increases the number of views by one" do
      a = valid_advert
      a.record_view
      expect(a.views).to equal(1)
    end

    it "saves itself" do
      a = valid_advert
      expect(a).to receive(:save)
      a.record_view
    end
  end

  describe "#old?" do
    it "returns true if the starts_at + number of months is in the past" do
      a = valid_advert
      a.starts_at = Time.zone.now - (1.year + 1.day)
      a.months = 12
      a.expires_at = Time.zone.now - 1.day
      expect(a.old?).to be_truthy
    end

    it "returns false if the starts_at + number of months is in the future" do
      a = valid_advert
      a.starts_at = Time.zone.now - 1.day
      a.months = 12
      a.expires_at = Time.zone.now + (1.year - 1.day)
      expect(a.old?).to be_falsey
    end

    it "returns false regardless of starts_at if expires_at is in the future" do
      a = valid_advert
      a.starts_at = Time.zone.now - (1.year + 1.day)
      a.months = 12
      a.expires_at = Time.zone.now + 1.hour
      expect(a.old?).to be_falsey
    end
  end

  def valid_advert
    Advert.new(user_id: 1)
  end
end
