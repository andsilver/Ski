require 'rails_helper'

module PierreEtVacances
  RSpec.describe Importer do
    describe '.import' do
      it 'downloads the file via FTP' do
        ftp = instance_double(FTP, xml_filename: 'property.xml')
        expect(FTP).to receive(:new).and_return(ftp)
        expect(ftp).to receive(:get)

        ai = instance_double(AccommodationImporter).as_null_object
        allow(AccommodationImporter).to receive(:new).and_return(ai)

        Importer.import
      end

      it 'skips download if skip_ftp is set in opts' do
        ftp = instance_double(FTP, xml_filename: 'property.xml')
        expect(FTP).to receive(:new).and_return(ftp)
        expect(ftp).not_to receive(:get)

        ai = instance_double(AccommodationImporter).as_null_object
        allow(AccommodationImporter).to receive(:new).and_return(ai)

        Importer.import(skip_ftp: true)
      end

      it 'imports P&V accommodation' do
        ftp = instance_double(FTP, xml_filename: 'property.xml', get: nil)
        allow(FTP).to receive(:new).and_return(ftp)

        ai = instance_double(AccommodationImporter)
        expect(AccommodationImporter).to receive(:new).and_return(ai)
        expect(ai)
          .to receive(:import)
          .with([File.join('pierreetvacances', 'property.xml')])

        Importer.import
      end
    end
  end
end
