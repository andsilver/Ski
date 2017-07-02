module TripAdvisor
  # Imports TripAdvisor location data into the local database.
  class LocationImporter
    attr_reader :io

    def initialize(io)
      @io = io
    end

    # Performs importing of the data.
    def import
      data = JSON.parse(io.read)

      import_location(nil, data)
    end

    # Imports a location and its children. Associates the location with its
    # parent.
    def import_location(parent_id, data)
      id = data['tripadvisorLocationId']

      create_location(id, parent_id, data) unless id.zero?

      return unless (children = data['children'])
      children.each { |c| import_location(id, c) }
    end

    private

    def create_location(id, parent_id, data)
      TripAdvisorLocation.create!(
        id: id,
        name: data['name'],
        location_type: data['type'],
        parent_id: parent_id.zero? ? nil : parent_id
      )
    end
  end
end
