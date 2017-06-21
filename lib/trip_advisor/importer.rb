module TripAdvisor
  # Handles the downloading and importing of the TripAdvisor data feeds.
  class Importer
    attr_reader :sftp_details

    def initialize(sftp_details:)
      @sftp_details = sftp_details
    end

    # Downloads and imports locations.
    def import_locations
      LocationDownloader.new(sftp_details: sftp_details).download
      LocationFileImporter.new(path: LocationDownloader.local_path).import
    end
  end
end
