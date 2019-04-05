module TripAdvisor
  # Imports TripAdvisor locations from a file on the local filesystem.
  class LocationFileImporter
    attr_reader :path

    def initialize(path:)
      @path = path
    end

    def import
      Rails.logger.info("Beginning TripAdvisor location import of #{path}")
      unless FileTest.exist?(path)
        Rails.logger.warn "Cannot import nonexistent location file: #{path}"
        return
      end

      File.open(path) { |io| LocationImporter.new(io).import }
      Rails.logger.info("Finished TripAdvisor location file import")
    end
  end
end
