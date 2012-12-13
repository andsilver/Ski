require 'spec_helper'
require 'xmlsimple'

module Interhome
  describe PlaceImporter do
    let(:filename) { "countryregionplace_en.xml" }

    describe '#ftp_get' do
      it 'gets the file via FTP' do
        FTP.should_receive(:get).with(filename)
        ipi = PlaceImporter.new
        ipi.ftp_get
      end
    end

    describe '#import' do
      it 'deletes all Interhome places' do
        f = mock('File').as_null_object
        File.stub(:open).and_return(f)
        XmlSimple.stub(:xml_in)
        InterhomePlace.should_receive(:delete_all)
        PlaceImporter.new.import
      end

      it 'opens the XML file' do
        XmlSimple.stub(:xml_in)
        File.should_receive(:open).
        with('interhome/' + filename, 'rb').
        and_return(mock('File').as_null_object)

        PlaceImporter.new.import
      end

      it 'closes the XML file' do
        XmlSimple.stub(:xml_in)
        f = mock('File')
        File.stub(:open).and_return(f)
        f.should_receive(:close)
        PlaceImporter.new.import
      end

      it 'creates an XML document' do
        f = mock('File').as_null_object
        File.stub(:open).and_return(f)
        XmlSimple.should_receive(:xml_in).with(f)
        PlaceImporter.new.import
      end

      it 'imports each country' do
        ipi = PlaceImporter.new
        # The sample XML document contains 2 countries
        ipi.stub(:xml_filename).and_return('spec/lib/countryregionplace_en.xml')
        ipi.should_receive(:import_country).twice
        ipi.import
      end
    end
  end
end
