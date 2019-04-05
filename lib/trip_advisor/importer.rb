# frozen_string_literal: true

module TripAdvisor
  # Handles the downloading and importing of the TripAdvisor data feeds.
  class Importer
    attr_reader :sftp_details

    def initialize(sftp_details:)
      @sftp_details = sftp_details
    end

    # Downloads and imports locations.
    def import_locations
      # Remove old location file.
      loc_path = LocationDownloader.local_path
      FileUtils.rm(loc_path) if File.exist?(loc_path)

      LocationDownloader.new(sftp_details: sftp_details).download

      LocationFileImporter.new(path: loc_path).import
    end

    # Downloads, extracts and imports properties.
    def import_properties
      downloader = PropertyDownloader.new(sftp_details: sftp_details)
      # As there is no delta feed on a Sunday, we need to download the full feed
      # instead for that day. As we download yesterday's data, we need to pull
      # the full Sunday feed on a Monday.
      archive = if Date.current.monday?
        downloader.download_full
      else
        downloader.download_delta
      end
      PropertyExtractor.new(path: archive).extract do |extracted|
        PropertyFileImporter.new(path: extracted).import
      end
    end
  end
end
