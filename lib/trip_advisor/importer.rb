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
      delta_archive = PropertyDownloader.new(sftp_details: sftp_details).download_delta
      PropertyExtractor.new(path: delta_archive).extract do |extracted|
        PropertyFileImporter.new(path: extracted).import
      end
    end
  end
end
