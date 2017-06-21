require 'rails_helper'

module TripAdvisor
  RSpec.describe LocationImporter do
    describe '#import' do
      def json
        %(
          {
            "tripadvisorLocationId" : 0,
            "name" : "Earth",
            "children" : [ {
              "tripadvisorLocationId" : 6,
              "name" : "Africa",
              "type" : "continent"
            }, {
              "tripadvisorLocationId" : 2,
              "name" : "Asia",
              "type" : "continent"
            } ]
          }
        )
      end

      before do
        io = StringIO.new(json)
        importer = LocationImporter.new(io)
        importer.import
      end

      it 'creates a TripAdvisorLocation for each entry' do
        expect(TripAdvisorLocation.count).to eq 3
      end

      it 'sets a name for each location' do
        expect(TripAdvisorLocation.first.name).to eq 'Earth'
      end

      it 'sets a location_type for each location' do
        expect(TripAdvisorLocation.last.location_type).to eq 'continent'
      end

      it 'sets a "planet" as the location_type for Earth' do
        expect(TripAdvisorLocation.last.location_type).to eq 'continent'
      end

      it 'sets the id as 1 + tripadvisorLocationId, as latter starts at 0' do
        expect(TripAdvisorLocation.find_by(name: 'Africa').id).to eq 7
      end

      it "sets the parent_id as 1 + the parent's tripadvisorLocationId" do
        expect(TripAdvisorLocation.find_by(name: 'Africa').parent_id).to eq 1
      end
    end
  end
end
