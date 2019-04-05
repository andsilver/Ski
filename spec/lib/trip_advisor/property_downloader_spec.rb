# frozen_string_literal: true

require "rails_helper"

module TripAdvisor
  RSpec.describe PropertyDownloader do
    def conn_info
      @conn_info ||= ["sftp.tripadvisor.com", "u", {password: "p"}]
    end

    describe "#download_full" do
      let(:test_details) { SFTPDetails.new("sftp.tripadvisor.com", "u", "p") }

      it "creates trip_advisor/listings directory if missing" do
        dir = File.join("trip_advisor", "listings")
        FileUtils.rm_rf dir

        sftp = instance_double(SFTP).as_null_object
        allow(SFTP).to receive(:new).and_return(sftp)

        downloader = PropertyDownloader.new(sftp_details: test_details)
        downloader.download_full(date: Date.today)

        expect(FileTest.exist?(dir)).to be_truthy
      end

      it "downloads listings_yyyymmdd.tar.gz from /drop/listings" do
        sftp = instance_double(SFTP)

        expect(SFTP)
          .to receive(:new).with(details: test_details).and_return(sftp)
        expect(sftp)
          .to receive(:download)
          .with(
            "/drop/listings/listings_20170714.tar.gz",
            local_full_path
          )

        downloader = PropertyDownloader.new(sftp_details: test_details)
        downloader.download_full(date: Date.new(2017, 7, 14))
      end

      it "returns the local path of the downloaded file" do
        sftp = instance_double(SFTP).as_null_object
        allow(SFTP).to receive(:new).and_return(sftp)

        downloader = PropertyDownloader.new(sftp_details: test_details)
        expect(downloader.download_full(date: Date.new(2017, 7, 14)))
          .to eq local_full_path
      end
    end

    describe "#download_delta" do
      let(:test_details) { SFTPDetails.new("sftp.tripadvisor.com", "u", "p") }

      it "creates trip_advisor/listings/delta directory if missing" do
        dir = File.join("trip_advisor", "listings", "delta")
        FileUtils.rm_rf dir

        sftp = instance_double(SFTP).as_null_object
        allow(SFTP).to receive(:new).and_return(sftp)

        downloader = PropertyDownloader.new(sftp_details: test_details)
        downloader.download_delta(date: Date.today)

        expect(FileTest.exist?(dir)).to be_truthy
      end

      it "downloads listings_delta_yyyymmdd.tar.gz from /drop/listings/delta" do
        sftp = instance_double(SFTP)

        expect(SFTP)
          .to receive(:new).with(details: test_details).and_return(sftp)
        expect(sftp)
          .to receive(:download)
          .with(
            "/drop/listings/delta/listings_delta_20170714.tar.gz",
            local_delta_path
          )

        downloader = PropertyDownloader.new(sftp_details: test_details)
        downloader.download_delta(date: Date.new(2017, 7, 14))
      end

      it "downloads Saturday's delta listings on a Sunday" do
        sftp = instance_double(SFTP)

        expect(SFTP)
          .to receive(:new).with(details: test_details).and_return(sftp)
        expect(sftp)
          .to receive(:download)
          .with(
            "/drop/listings/delta/listings_delta_20170805.tar.gz",
            File.join(local_delta_directory, "listings_delta_20170805.tar.gz")
          )

        downloader = PropertyDownloader.new(sftp_details: test_details)
        downloader.download_delta(date: Date.new(2017, 8, 6))
      end

      it "returns the local path of the downloaded file" do
        sftp = instance_double(SFTP).as_null_object
        allow(SFTP).to receive(:new).and_return(sftp)

        downloader = PropertyDownloader.new(sftp_details: test_details)
        expect(downloader.download_delta(date: Date.new(2017, 7, 14)))
          .to eq local_delta_path
      end
    end

    def local_full_path
      File.join(local_full_directory, "listings_20170714.tar.gz")
    end

    def local_full_directory
      File.join(Rails.root, "trip_advisor", "listings")
    end

    def local_delta_path
      File.join(local_delta_directory, "listings_delta_20170714.tar.gz")
    end

    def local_delta_directory
      File.join(Rails.root, "trip_advisor", "listings", "delta")
    end
  end
end
