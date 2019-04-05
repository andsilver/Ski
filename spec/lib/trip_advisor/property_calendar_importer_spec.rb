# frozen_string_literal: true

require "rails_helper"

module TripAdvisor
  RSpec.describe PropertyCalendarImporter do
    def json(id = 7_363_690)
      File.read(
        File.join(
          Rails.root, "test-files", "trip_advisor", "properties", "#{id}.json"
        )
      )
    end

    let(:calendar) { JSON.parse(json)["calendar"] }
    let(:ta_prop) { FactoryBot.create(:trip_advisor_property) }

    describe "#import" do
      def import
        importer = PropertyCalendarImporter.new(ta_prop, calendar)
        importer.import
      end

      it "deletes existing calendar entries for the TripAdvisorProperty" do
        FactoryBot.create(
          :trip_advisor_calendar_entry, trip_advisor_property: ta_prop
        )
        import
        expect(TripAdvisorCalendarEntry.count).to eq 2
      end

      it "creates a calendar entry for each entry in the calendar" do
        import
        expect(TripAdvisorCalendarEntry.count).to eq 2
      end

      it "associates entries with the TripAdvisorProperty" do
        import
        e = TripAdvisorCalendarEntry.first
        expect(e.trip_advisor_property_id).to eq ta_prop.id
      end

      it "sets the inclusive start date" do
        import
        e = TripAdvisorCalendarEntry.first
        expect(e.inclusive_start).to eq Date.parse("2017-07-22")
      end

      it "sets the exclusive end date" do
        import
        e = TripAdvisorCalendarEntry.first
        expect(e.exclusive_end).to eq Date.parse("2017-07-29")
      end

      it "sets the status" do
        import
        e = TripAdvisorCalendarEntry.first
        expect(e.status).to eq "BOOKED"
      end
    end
  end
end
