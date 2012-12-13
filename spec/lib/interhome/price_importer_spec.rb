require 'spec_helper'

module Interhome
  describe PriceImporter do
    let(:sales_office) { '1234' }
    let(:days) { 7 }

    describe '#initialize' do
      it 'sets @sales_office and @days from its parameters' do
        ipi = PriceImporter.new(sales_office, days)
        ipi.sales_office.should == sales_office
        ipi.days.should == days
      end
    end

    describe '#ftp_get' do
      it 'gets the file corresponding to the sales office and 7 days via FTP' do
        FTP.should_receive(:get).with('price_1234_eur.xml')
        ipi = PriceImporter.new(sales_office, 7)
        ipi.ftp_get
      end

      it 'gets the file corresponding to the sales office and 14 days via FTP' do
        FTP.should_receive(:get).with('price_1234_eur_14.xml')
        ipi = PriceImporter.new(sales_office, 14)
        ipi.ftp_get
      end
    end

    describe '#import' do
      it 'deletes all Interhome prices for @days days' do
        InterhomePrice.should_receive(:delete_all).with(:days => days)
        PriceImporter.new(sales_office, days).import([])
      end

      it 'imports each file in the array' do
        ipi = PriceImporter.new(sales_office, days)
        ipi.should_receive(:import_file).with('file1.xml')
        ipi.should_receive(:import_file).with('file2.xml')
        ipi.import(['file1.xml', 'file2.xml'])
      end
    end
  end
end
