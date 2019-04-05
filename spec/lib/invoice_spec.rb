require "rails_helper"

describe Invoice do
  describe "#render" do
    it "creates a PDF document" do
      pending "Aller font cannot be redistributed so absent from repo"
      order = FactoryBot.build(:order)
      order.save!
      invoice = Invoice.new(order)
      invoice.render
      expect(File.exist?(invoice.filename)).to be_true
    end
  end

  describe "#directory" do
    it "returns a directory in Rails root based on the order hash" do
      order = double(Order, hash: "hash")
      expect(Invoice.new(order).directory).to eq "#{Rails.root}/public/invoices/hash"
    end
  end

  describe "#filename" do
    it "returns a filename, including path, based on the order number" do
      order = double(Order, order_number: "1234")
      invoice = Invoice.new(order)
      allow(invoice).to receive(:directory).and_return "/tmp"
      expect(invoice.filename).to eq "/tmp/MCF-Invoice-1234.pdf"
    end
  end
end
