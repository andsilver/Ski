require 'spec_helper'

describe OrdersController do
  let(:website) { mock_model(Website).as_null_object }

  before { Website.stub(:first).and_return(website) }

  describe 'GET invoice' do
    context 'when signed in' do
      before { signed_in }

      let(:order) { mock_model(Order).as_null_object }
      let(:invoice) { double(Invoice, filename: 'test-files/invoice.pdf') }

      it 'finds the order' do
        Order.should_receive(:find_by).and_return(order)
        Invoice.stub(:new).and_return(invoice)
        invoice.stub(:render)
        get 'invoice', id: '1'
      end

      it 'creates a new invoice with the order' do
        Order.stub(:find_by).and_return(order)
        Invoice.should_receive(:new).with(order).and_return(invoice)
        invoice.stub(:render)
        get 'invoice', id: '1'
      end

      it 'renders the invoice' do
        Order.stub(:find_by).and_return(order)
        Invoice.stub(:new).and_return(invoice)
        invoice.should_receive(:render)
        get 'invoice', id: '1'        
      end
    end
  end
end
