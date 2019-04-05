require "rails_helper"
require "xmlsimple"

module Interhome
  describe PlaceImporter do
    let(:filename) { "countryregionplace_en.xml" }

    describe "#ftp_get" do
      it "gets the file via FTP" do
        expect(FTP).to receive(:get).with(filename)
        ipi = PlaceImporter.new
        ipi.ftp_get
      end
    end

    describe "#import" do
      it "deletes all Interhome places" do
        f = double("File").as_null_object
        allow(File).to receive(:open).and_return(f)
        allow(XmlSimple).to receive(:xml_in)
        expect(InterhomePlace).to receive(:delete_all)
        PlaceImporter.new.import
      end

      it "opens the XML file" do
        allow(XmlSimple).to receive(:xml_in)
        expect(File).to receive(:open)
          .with("interhome/" + filename, "rb")
          .and_return(double("File").as_null_object)

        PlaceImporter.new.import
      end

      it "closes the XML file" do
        allow(XmlSimple).to receive(:xml_in)
        f = double("File")
        allow(File).to receive(:open).and_return(f)
        expect(f).to receive(:close)
        PlaceImporter.new.import
      end

      it "creates an XML document" do
        f = double("File").as_null_object
        allow(File).to receive(:open).and_return(f)
        expect(XmlSimple).to receive(:xml_in).with(f)
        PlaceImporter.new.import
      end

      it "imports each country" do
        ipi = PlaceImporter.new
        # The sample XML document contains 2 countries
        allow(ipi).to receive(:xml_filename).and_return("spec/lib/countryregionplace_en.xml")
        expect(ipi).to receive(:import_country).twice
        ipi.import
      end
    end
  end
end
