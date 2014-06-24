require 'rails_helper'

describe PaymentsController do
  let(:website) { double(Website).as_null_object }
  let(:payment) { double(Payment).as_null_object }

  before do
    Website.stub(:first).and_return(website)
    website.stub(:worldpay_payment_response_password).and_return('secret')
    Payment.stub(:new).and_return(payment)
  end

  describe 'POST worldpay_callback' do
    it 'creates a new payment' do
      Payment.should_receive(:new)
      post 'worldpay_callback'
    end

    it 'sets the service provider as WorldPay' do
      payment.should_receive(:service_provider=).with('WorldPay')
      post 'worldpay_callback'
    end

    it 'saves the payment' do
      payment.should_receive(:save).twice
      post 'worldpay_callback'
    end

    context 'when FuturePay' do
      it 'sets the FuturePay ID' do
        payment.should_receive(:futurepay_id=).with('1234')
        post 'worldpay_callback', futurePayId: '1234'
      end

      context 'when in test mode' do
        let(:params) { {futurePayId: '1234', testMode: '100', cartId: '1',
          transStatus: 'Y', callbackPW: 'secret'} }

        before do
          website.stub(:worldpay_test_mode).and_return(true)
        end

        it 'accepts the payment regardless' do
          controller.stub(:complete_order)
          payment.should_receive(:accepted=).with(false) # expected first time, for safety
          payment.should_receive(:accepted=).with(true)
          post 'worldpay_callback', params
        end
      end
    end
  end
end
