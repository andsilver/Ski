require "rails_helper"

module TripAdvisor
  RSpec.describe LocationImporter do
    describe "#import" do
      def json
        %(
          {
            "tripadvisorLocationId" : 0,
            "name" : "Earth",
            "children" : [ {
              "tripadvisorLocationId" : 6,
              "name" : "Africa",
              "type" : "continent",
              "children" : [ {
                "tripadvisorLocationId" : 293808,
                "name" : "Madagascar",
                "type" : "country"
              } ]
            }, {
              "tripadvisorLocationId" : 2,
              "name" : "Asia",
              "type" : "continent"
            } ]
          }
        )
      end

      before do
        TripAdvisorLocation.create!(
          id: 293808, name: "Malawi", location_type: "country", parent_id: 6
        )
        io = StringIO.new(json)
        importer = LocationImporter.new(io)
        importer.import
      end

      it "creates a TripAdvisorLocation for each entry except Earth" do
        expect(TripAdvisorLocation.count).to eq 3
      end

      it "sets a name for each location" do
        expect(TripAdvisorLocation.first.name).to eq "Asia"
      end

      it "sets a location_type for each location" do
        expect(TripAdvisorLocation.find_by(name: "Africa").location_type)
          .to eq "continent"
      end

      it "sets the id as the tripadvisorLocationId" do
        expect(TripAdvisorLocation.find_by(name: "Africa").id).to eq 6
      end

      it "updates existing locations" do
        expect(TripAdvisorLocation.find_by(id: 293808).name).to eq "Madagascar"
      end

      it "sets the parent_id to the parent's tripadvisorLocationId" do
        expect(TripAdvisorLocation.find_by(name: "Madagascar").parent_id)
          .to eq 6
      end

      it "sets the parent_id to nil when parent is Earth" do
        expect(TripAdvisorLocation.find_by(name: "Africa").parent_id).to be_nil
      end
    end
  end
end
