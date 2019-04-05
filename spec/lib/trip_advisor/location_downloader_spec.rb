require "rails_helper"

module TripAdvisor
  RSpec.describe LocationDownloader do
    describe "#download" do
      it "downloads locations.json from /drop/locations" do
        conn_info = ["sftp.tripadvisor.com", "u", {password: "p"}]

        sftp = instance_double(Net::SFTP::Session)

        expect(Net::SFTP).to receive(:start).with(*conn_info).and_yield(sftp)
        expect(sftp)
          .to receive(:download!)
          .with(
            "/drop/locations/locations.json",
            local_path
          )

        downloader = LocationDownloader.new(
          sftp_details: SFTPDetails.new("sftp.tripadvisor.com", "u", "p")
        )
        downloader.download
      end
    end

    def local_path
      File.join(Rails.root, "trip_advisor", "locations.json")
    end

    describe ".local_path" do
      it "returns a path to the downloaded file" do
        expect(LocationDownloader.local_path).to eq local_path
      end
    end
  end
end
