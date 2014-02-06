require 'spec_helper'

describe Invoice do
  describe '#render' do
    it 'creates a PDF document' do
      order = FactoryGirl.build(:order)
      order.save!
      invoice = Invoice.new(order)
      invoice.render
      expect(File.exist?(invoice.filename)).to be_true
    end
  end

  describe '#directory' do
    it 'returns a directory in Rails root based on the order hash' do
      order = mock_model(Order, hash: 'hash')
      expect(Invoice.new(order).directory).to eq "#{Rails.root.to_s}/public/invoices/hash"
    end
  end

  describe '#filename' do
    it 'returns a filename, including path, based on the order number' do
      order = mock_model(Order, order_number: '1234')
      invoice = Invoice.new(order)
      invoice.stub(:directory).and_return '/tmp'
      expect(invoice.filename).to eq '/tmp/MCF-Invoice-1234.pdf'
    end
  end
end
