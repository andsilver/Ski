require "rails_helper"

module TripAdvisor
  RSpec.describe PropertyFileImporter do
    describe "#import" do
      it "opens the file at path and asks PropertyImporter to import each " \
      "line of JSON" do
        path = "trip_advisor/listings_delta_yyyymmdd.txt"

        pi1 = instance_double(PropertyImporter)
        pi2 = instance_double(PropertyImporter)

        expect(File)
          .to receive(:foreach).with(path)
          .and_yield("{\"id\":1}\n").and_yield("{\"id\":2}\n")

        expect(PropertyImporter)
          .to receive(:new).with("{\"id\":1}\n").and_return(pi1)
        expect(pi1).to receive(:import)
        expect(PropertyImporter)
          .to receive(:new).with("{\"id\":2}\n").and_return(pi2)
        expect(pi2).to receive(:import)

        sut = PropertyFileImporter.new(path: path)
        sut.import_without_delay
      end
    end
  end
end
