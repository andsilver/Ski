require "rails_helper"

RSpec.describe TripAdvisorImportJob, type: :job do
  describe "#perform" do
    it "imports locations" do
      importer = instance_double(TripAdvisor::Importer).as_null_object
      allow(TripAdvisor::Importer).to receive(:new).and_return(importer)

      expect(importer).to receive(:import_locations)

      TripAdvisorImportJob.new.perform
    end

    it "imports properties" do
      importer = instance_double(TripAdvisor::Importer).as_null_object
      allow(TripAdvisor::Importer).to receive(:new).and_return(importer)

      expect(importer).to receive(:import_properties)

      TripAdvisorImportJob.new.perform
    end
  end
end
