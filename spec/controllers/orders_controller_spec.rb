require "rails_helper"

RSpec.describe OrdersController, type: :controller do
  let(:website) { double(Website).as_null_object }

  before { allow(Website).to receive(:first).and_return(website) }

  describe "GET invoice" do
    context "when signed in" do
      before { signed_in }

      let(:order) { double(Order).as_null_object }
      let(:invoice) { double(Invoice, filename: "test-files/invoice.pdf") }

      it "finds the order" do
        expect(Order).to receive(:find_by).and_return(order)
        allow(Invoice).to receive(:new).and_return(invoice)
        allow(invoice).to receive(:render)
        get "invoice", params: {id: "1"}
      end

      it "creates a new invoice with the order" do
        allow(Order).to receive(:find_by).and_return(order)
        expect(Invoice).to receive(:new).with(order).and_return(invoice)
        allow(invoice).to receive(:render)
        get "invoice", params: {id: "1"}
      end

      it "renders the invoice" do
        allow(Order).to receive(:find_by).and_return(order)
        allow(Invoice).to receive(:new).and_return(invoice)
        expect(invoice).to receive(:render)
        get "invoice", params: {id: "1"}
      end
    end
  end
end
