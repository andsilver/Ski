module TripAdvisor
  # Imports TripAdvisor location data into the local database.
  class LocationImporter
    attr_reader :io

    def initialize(io)
      @io = io
    end

    # Performs importing of the data.
    def import
      Rails.logger.info("Beginning import of TripAdvisor location data")
      data = JSON.parse(io.read)

      import_location(nil, data)
      Rails.logger.info("Finished import of TripAdvisor location data")
    end

    # Imports a location and its children. Associates the location with its
    # parent.
    def import_location(parent_id, data)
      id = data["tripadvisorLocationId"]

      update_location(id, parent_id, data) unless id.zero?

      return unless (children = data["children"])
      children.each { |c| import_location(id, c) }
    end

    private

    def update_location(id, parent_id, data)
      location = TripAdvisorLocation.find_or_initialize_by(id: id)
      location.name = data["name"]
      location.location_type = data["type"]
      location.parent_id = parent_id.zero? ? nil : parent_id
      location.save
    end
  end
end
