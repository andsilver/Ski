require 'spec_helper'

describe PaymentsController do
  let(:website) { mock_model(Website).as_null_object }
  let(:payment) { mock_model(Payment).as_null_object }

  before do
    Website.stub(:first).and_return(website)
    Payment.stub(:new).and_return(payment)
  end

  describe "POST worldpay_callback" do
    it "creates a new payment" do
      Payment.should_receive(:new)
      post :worldpay_callback
    end

    it "saves the payment" do
      payment.should_receive(:save).twice
      post :worldpay_callback
    end
  end
end
