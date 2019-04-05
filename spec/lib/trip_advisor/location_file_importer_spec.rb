require "rails_helper"

module TripAdvisor
  RSpec.describe LocationFileImporter do
    describe "#import" do
      let(:path) { "path/to/locations.json" }

      context "when file exists" do
        before do
          allow(FileTest).to receive(:exist?).with(path).and_return(true)
        end

        it "opens the file at path and asks LocationImporter to import it" do
          io = instance_double(IO)
          li = instance_double(LocationImporter)

          expect(File).to receive(:open).with(path).and_yield(io)
          expect(LocationImporter).to receive(:new).with(io).and_return(li)
          expect(li).to receive(:import)

          sut = LocationFileImporter.new(path: path)
          sut.import
        end

        it "does not log a warning" do
          expect(Rails.logger).not_to receive(:warn)

          allow(File).to receive(:open)
          sut = LocationFileImporter.new(path: path)
          sut.import
        end
      end

      context "when file does not exist" do
        before do
          allow(FileTest).to receive(:exist?).with(path).and_return(false)
        end

        it "logs a warning" do
          expect(Rails.logger).to receive(:warn)
          sut = LocationFileImporter.new(path: path)
          sut.import
        end

        it "does not attempt to open the file" do
          expect(File).not_to receive(:open)
          sut = LocationFileImporter.new(path: path)
          sut.import
        end
      end
    end
  end
end
