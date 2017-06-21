require 'rails_helper'

module TripAdvisor
  RSpec.describe Importer do
    describe '#import_locations' do
      it 'downloads locations' do
        stub_importer

        details = instance_double(SFTPDetails)
        downloader = instance_double(LocationDownloader)
        expect(LocationDownloader)
          .to receive(:new)
          .with(sftp_details: details)
          .and_return(downloader)
        expect(downloader).to receive(:download)

        Importer.new(sftp_details: details).import_locations
      end
    end

    def stub_importer
      lfi = instance_double(LocationFileImporter, import: nil)
      allow(LocationFileImporter).to receive(:new).and_return(lfi)
    end

    it 'imports locations' do
      downloader = instance_double(LocationDownloader, download: nil)
      allow(LocationDownloader).to receive(:new).and_return(downloader)

      lfi = instance_double(LocationFileImporter)

      expect(LocationFileImporter)
        .to receive(:new)
        .with(path: LocationDownloader.local_path)
        .and_return(lfi)
      expect(lfi).to receive(:import)

      Importer.new(sftp_details: SFTPDetails.default).import_locations
    end
  end
end
