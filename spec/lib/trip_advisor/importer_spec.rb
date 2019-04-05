# frozen_string_literal: true

require "rails_helper"

module TripAdvisor
  RSpec.describe Importer do
    describe "#import_locations" do
      it "downloads locations" do
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

    it "imports locations" do
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

    describe "#import_properties" do
      let(:date) { Date.new(2018, 3, 9) } # A Friday
      let(:details) { instance_double(SFTPDetails) }

      before { allow(Date).to receive(:current).and_return(date) }

      it "downloads a listings delta archive" do
        downloader = instance_double(PropertyDownloader)

        allow(PropertyExtractor)
          .to receive(:new)
          .and_return(instance_double(PropertyExtractor).as_null_object)

        expect(PropertyDownloader)
          .to receive(:new)
          .with(sftp_details: details)
          .and_return(downloader)
        expect(downloader).to receive(:download_delta)

        Importer.new(sftp_details: details).import_properties
      end

      it "extracts the delta archive" do
        path = "path/to/archive.tar.gz"
        downloader = instance_double(PropertyDownloader, download_delta: path)
        allow(PropertyDownloader).to receive(:new).and_return(downloader)

        extractor = instance_double(PropertyExtractor)
        expect(PropertyExtractor)
          .to receive(:new).with(path: path)
          .and_return(extractor)
        expect(extractor).to receive(:extract)

        Importer.new(sftp_details: details).import_properties
      end

      it "queues up a property file importer for each path" do
        path = "path/to/archive.tar.gz"
        downloader = instance_double(PropertyDownloader, download_delta: path)
        allow(PropertyDownloader).to receive(:new).and_return(downloader)

        extractor = instance_double(PropertyExtractor)
        allow(PropertyExtractor).to receive(:new).and_return(extractor)
        allow(extractor).to receive(:extract).and_yield("f1").and_yield("f2")

        ["f1", "f2"].each do |f|
          fi = instance_double(PropertyFileImporter)
          expect(PropertyFileImporter)
            .to receive(:new).with(path: f).and_return(fi)
          expect(fi).to receive(:import)
        end

        Importer.new(sftp_details: details).import_properties
      end

      context "on a Monday" do
        let(:date) { Date.new(2018, 3, 12) }

        it "downloads a full listings archive" do
          downloader = instance_double(PropertyDownloader)

          allow(PropertyExtractor)
            .to receive(:new)
            .and_return(instance_double(PropertyExtractor).as_null_object)

          expect(PropertyDownloader)
            .to receive(:new)
            .with(sftp_details: details)
            .and_return(downloader)
          expect(downloader).to receive(:download_full)

          Importer.new(sftp_details: details).import_properties
        end
      end
    end
  end
end
