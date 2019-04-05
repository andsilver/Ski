require "rails_helper"

describe BasketLine do
  describe "#initialize" do
    it "sets @windows to 0" do
      expect(BasketLine.new.windows).to eq 0
    end
  end

  describe "#order_description" do
    context "with an advert" do
      let(:advert) { double(Advert, months: 12, to_s: "Advert") }

      before do
        @bl = BasketLine.new
        @bl.advert = advert
      end

      context "without a coupon" do
        it "describes the advert" do
          expect(@bl.order_description).to eq "12 month(s): Advert"
        end
      end

      context "with a coupon" do
        before do
          @bl.coupon = Coupon.new
          @bl.description = "Coupon description"
        end

        it "describes the advert and the coupon description in brackets" do
          expect(@bl.order_description).to eq "12 month(s): Advert [Coupon description]"
        end
      end
    end

    context "without an advert" do
      it "returns @description" do
        bl = BasketLine.new
        bl.description = "Line"
        expect(bl.order_description).to eq "Line"
      end
    end
  end

  describe "#pay_monthly?" do
    it "returns true when there are windows" do
      bl = BasketLine.new
      bl.windows = "1"
      expect(bl.pay_monthly?).to be_truthy
    end

    it "returns false when there are no windows" do
      bl = BasketLine.new
      bl.windows = "0"
      expect(bl.pay_monthly?).to be_falsey
    end
  end

  describe "#first_payment" do
    it "returns price - 11 subsequent payments" do
      bl = BasketLine.new
      bl.price = 145
      allow(bl).to receive(:subsequent_payments).and_return(12)
      expect(bl.first_payment).to eq 13
    end
  end

  describe "#subsequent_payments" do
    it "returns the integer price / 12" do
      bl = BasketLine.new
      bl.price = 145
      expect(bl.subsequent_payments).to eq 12
    end
  end
end
