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
      # TripAdvisor locations start at 0. Since we're using MySQL, a 0 primary
      # key would be considered an instruction to use the auto increment value
      # by default. So we add one instead.
      id = data['tripadvisorLocationId'] + 1
      TripAdvisorLocation.create!(
        id: id,
        name: data['name'],
        location_type: data['type'] || 'Earth',
        parent_id: parent_id
      )
      return unless (children = data['children'])
      children.each { |c| import_location(id, c) }
    end
  end
end
