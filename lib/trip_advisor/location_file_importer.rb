module TripAdvisor
  # Imports TripAdvisor locations from a file on the local filesystem.
  class LocationFileImporter
    attr_reader :path

    def initialize(path:)
      @path = path
    end

    def import
      File.open(path) { |io| LocationImporter.new(io).import }
    end
  end
end
