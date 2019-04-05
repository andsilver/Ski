require "rails_helper"

RSpec.describe PaymentsController, type: :controller do
  let(:website) { double(Website).as_null_object }
  let(:payment) { double(Payment).as_null_object }

  before do
    allow(Website).to receive(:first).and_return(website)
    allow(website).to receive(:worldpay_payment_response_password).and_return("secret")
    allow(Payment).to receive(:new).and_return(payment)
  end

  describe "POST worldpay_callback" do
    it "creates a new payment" do
      expect(Payment).to receive(:new)
      post "worldpay_callback"
    end

    it "sets the service provider as WorldPay" do
      expect(payment).to receive(:service_provider=).with("WorldPay")
      post "worldpay_callback"
    end

    it "saves the payment" do
      expect(payment).to receive(:save).twice
      post "worldpay_callback"
    end

    context "when FuturePay" do
      it "sets the FuturePay ID" do
        expect(payment).to receive(:futurepay_id=).with("1234")
        post "worldpay_callback", params: {futurePayId: "1234"}
      end

      context "when in test mode" do
        let(:params) {
          {futurePayId: "1234", testMode: "100", cartId: "1",
           transStatus: "Y", callbackPW: "secret",}
        }

        before do
          allow(website).to receive(:worldpay_test_mode).and_return(true)
        end

        it "accepts the payment regardless" do
          allow(controller).to receive(:complete_order)
          expect(payment).to receive(:accepted=).with(false) # expected first time, for safety
          expect(payment).to receive(:accepted=).with(true)
          post "worldpay_callback", params: params
        end
      end
    end
  end

  describe "GET complete_payment_not_required" do
    context "with windows and 0 order value" do
      let(:order) { FactoryBot.create(:order, status: Order::PAYMENT_NOT_REQUIRED, total: 0) }

      before do
        OrderLine.create!(
          order: order,
          description: "Windows",
          amount: 0,
          windows: 10
        )
        session[:order_id] = order.id
      end

      it "activates windows for 12 months" do
        expect(Advert).to receive(:activate_windows_for_user).with(10, order, 12)
        get :complete_payment_not_required
      end
    end
  end
end
