require 'spec_helper'
require 'xmlsimple'

module PierreEtVacances
  describe AccommodationImporter do
    describe '#ftp_get' do
      it 'gets the XML file from the FTP server' do
        i = PierreEtVacances::AccommodationImporter.new
        i.should_receive(:xml_filename).and_return('accom.xml')
        FTP.should_receive(:get).with('accom.xml')
        i.ftp_get
      end
    end

    describe '#xml_filename' do
      it "returns the most recent summer property XML filename from the FTP server" do
        FTP.should_receive(:property_filename).with(:summer).and_return('EN_PV_AA_E13_GENERAL_11Feb2013.xml')
        i = PierreEtVacances::AccommodationImporter.new
        i.xml_filename.should eq 'EN_PV_AA_E13_GENERAL_11Feb2013.xml'
      end
    end

    describe '#import' do
    end
  end
end
