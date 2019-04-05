require "rails_helper"

module Interhome
  describe Importer do
    describe "#import" do
      before do
        allow(PlaceImporter).to receive(:new).and_return(double(PlaceImporter).as_null_object)
        allow(PriceImporter).to receive(:new).and_return(double(PriceImporter).as_null_object)
        allow(DescriptionImporter).to receive(:new).and_return(double(DescriptionImporter).as_null_object)
        allow(AccommodationImporter).to receive(:new).and_return(double(AccommodationImporter).as_null_object)
        allow(VacancyImporter).to receive(:new).and_return(double(VacancyImporter).as_null_object)
      end

      it "imports places" do
        importer = Importer.new
        expect(importer).to receive(:import_places)
        importer.import
      end

      it "imports prices" do
        importer = Importer.new
        expect(importer).to receive(:import_prices)
        importer.import
      end

      it "imports inside and outside descriptions" do
        importer = Importer.new
        expect(importer).to receive(:import_descriptions).with("InterhomeInsideDescription")
        expect(importer).to receive(:import_descriptions).with("InterhomeOutsideDescription")
        importer.import
      end

      it "imports accommodation" do
        importer = Importer.new
        expect(importer).to receive(:import_accommodation)
        importer.import
      end

      it "imports vacancies" do
        importer = Importer.new
        expect(importer).to receive(:import_vacancies)
        importer.import
      end
    end
  end
end
