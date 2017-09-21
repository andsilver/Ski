# frozen_string_literal: true

module TripAdvisor
  # Imports TripAdvisor properties (listings) from a file on the local
  # filesystem.
  class PropertyFileImporter
    attr_reader :path

    def initialize(path:)
      @path = path
    end

    def import
      File.foreach(path) { |json_line| PropertyImporter.new(json_line).import }
    end
    handle_asynchronously :import
  end
end
