require 'spec_helper'

module Interhome
  describe Importer do
    describe '#import' do
      before do
        PlaceImporter.stub(:new).and_return(double(PlaceImporter).as_null_object)
        PriceImporter.stub(:new).and_return(double(PriceImporter).as_null_object)
        DescriptionImporter.stub(:new).and_return(double(DescriptionImporter).as_null_object)
        AccommodationImporter.stub(:new).and_return(double(AccommodationImporter).as_null_object)
        VacancyImporter.stub(:new).and_return(double(VacancyImporter).as_null_object)
      end

      it 'imports places' do
        importer = Importer.new
        importer.should_receive(:import_places)
        importer.import
      end

      it 'imports prices' do
        importer = Importer.new
        importer.should_receive(:import_prices)
        importer.import
      end

      it 'imports inside and outside descriptions' do
        importer = Importer.new
        importer.should_receive(:import_descriptions).with('InterhomeInsideDescription')
        importer.should_receive(:import_descriptions).with('InterhomeOutsideDescription')
        importer.import
      end

      it 'imports accommodation' do
        importer = Importer.new
        importer.should_receive(:import_accommodation)
        importer.import
      end

      it 'imports vacancies' do
        importer = Importer.new
        importer.should_receive(:import_vacancies)
        importer.import
      end
    end
  end
end
