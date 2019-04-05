require "rails_helper"

module Interhome
  describe PriceImporter do
    let(:sales_office) { "1234" }
    let(:days) { 7 }

    describe "#initialize" do
      it "sets @sales_office and @days from its parameters" do
        ipi = PriceImporter.new(sales_office, days)
        expect(ipi.sales_office).to eq sales_office
        expect(ipi.days).to eq days
      end
    end

    describe "#ftp_get" do
      it "gets the file corresponding to the sales office and 7 days via FTP" do
        expect(FTP).to receive(:get).with("price_1234_gbp.xml")
        ipi = PriceImporter.new(sales_office, 7)
        ipi.ftp_get
      end

      it "gets the file corresponding to the sales office and 14 days via FTP" do
        expect(FTP).to receive(:get).with("price_1234_gbp_14.xml")
        ipi = PriceImporter.new(sales_office, 14)
        ipi.ftp_get
      end
    end

    describe "#import" do
      it "deletes all Interhome prices for @days days" do
        p1 = FactoryBot.create(:interhome_price, days: days)
        p2 = FactoryBot.create(:interhome_price, days: days + 1)
        PriceImporter.new(sales_office, days).import([])
        expect(InterhomePrice.exists?(p1.id)).to be_falsey
        expect(InterhomePrice.exists?(p2.id)).to be_truthy
      end

      it "imports each file in the array" do
        ipi = PriceImporter.new(sales_office, days)
        expect(ipi).to receive(:import_file).with("file1.xml")
        expect(ipi).to receive(:import_file).with("file2.xml")
        ipi.import(["file1.xml", "file2.xml"])
      end
    end
  end
end
