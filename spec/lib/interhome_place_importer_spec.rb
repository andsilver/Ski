require 'spec_helper'
require 'xmlsimple'

describe InterhomePlaceImporter do
  let(:filename) { "#{Rails::root.to_s}/spec/lib/countryregionplace_en.xml" }

  describe '#initialize' do
    it 'sets @xml_filename from its parameter' do
      ipi = InterhomePlaceImporter.new(filename)
      ipi.xml_filename.should == filename
    end
  end

  describe '#ftp_get' do
    it 'gets the file via FTP' do
      InterhomeFTP.should_receive(:get, :with => filename)
      ipi = InterhomePlaceImporter.new(filename)
      ipi.ftp_get
    end
  end

  describe '#import' do
    it 'deletes all Interhome places' do
      InterhomePlace.should_receive(:delete_all)
      InterhomePlaceImporter.new(filename).import
    end

    it 'opens the XML file' do
      XmlSimple.stub(:xml_in)
      File.should_receive(:open).
      with(filename, 'rb').
      and_return(mock('File').as_null_object)

      InterhomePlaceImporter.new(filename).import
    end

    it 'closes the XML file' do
      XmlSimple.stub(:xml_in)
      f = mock('File')
      File.stub(:open).and_return(f)
      f.should_receive(:close)
      InterhomePlaceImporter.new(filename).import
    end

    it 'creates an XML document' do
      f = mock('File').as_null_object
      File.stub(:open).and_return(f)
      XmlSimple.should_receive(:xml_in).with(f)
      InterhomePlaceImporter.new(filename).import
    end

    it 'imports each country' do
      ipi = InterhomePlaceImporter.new(filename)
      # The sample XML document contains 2 countries
      ipi.should_receive(:import_country).twice
      ipi.import
    end
  end
end
