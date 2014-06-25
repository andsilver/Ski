require 'spec_helper'
require 'flip_key'

module FlipKey
  describe Importer do
    let(:importer) { Importer.new }
    let(:dir_entries) { [
      '.',
      '..',
      'property_data_13.xml',
      'property_data_13.10.xml',
      'property_data_13.xml.gz'
    ] }

    describe '#import' do
      it 'imports locations' do
        importer.stub(:import_properties)
        importer.should_receive(:import_locations)
        importer.import
      end

      it 'imports properties' do
        importer.stub(:import_locations)
        importer.should_receive(:import_properties)
        importer.import
      end
    end

    describe '#import_properties' do
      it 'calls perform_import with property import settings' do
        importer
          .should_receive(:perform_import)
          .with(PropertyDownloader, PropertyImporter, anything(), Importer::PROPERTY_XML_SPLIT_OPTIONS)
        importer.import_properties
      end
    end

    describe '#property_filenames' do
      it 'returns an array of splitted property XML filenames, including the FlipKey directory' do
        Dir.stub(:entries).with(FlipKey.directory).and_return(dir_entries)
        expect(importer.property_filenames).to eq [File.join(FlipKey.directory, 'property_data_13.10.xml')]
      end
    end

    describe '#perform_import' do
      class FakeDownloader
        def initialize(x); end

        def download
          yield 'data.xml.gz'
        end
      end

      class FakeImporter
        def import(x); end
      end

      let(:filenames) { -> { ['data1.xml'] } }

      it 'creates a downloader and requests download' do
        downloader = double(FakeDownloader)
        FakeDownloader.should_receive(:new).and_return(downloader)
        downloader.should_receive(:download)

        importer.perform_import(FakeDownloader, FakeImporter, filenames, {})
      end

      it 'gunzips filenames yielded by the downloader' do
        XMLSplitter.stub(:new).and_return double(XMLSplitter).as_null_object
        importer.should_receive(:gunzip).with('data.xml.gz')
        importer.perform_import(FakeDownloader, FakeImporter, filenames, {})
      end

      it 'splits the large XML files into smaller ones' do
        xml_splitter = double(XMLSplitter)
        XMLSplitter
          .should_receive(:new)
          .with({ xml_filename: File.join(FlipKey.directory, 'data.xml') }.merge Importer::PROPERTY_XML_SPLIT_OPTIONS)
          .and_return(xml_splitter)
        xml_splitter.should_receive(:split)

        importer.stub(:gunzip)

        importer.perform_import(FakeDownloader, FakeImporter, filenames, Importer::PROPERTY_XML_SPLIT_OPTIONS)
      end

      it 'creates an importer and requests it to import the filenames' do
        fake_importer = double(FakeImporter)
        FakeImporter.should_receive(:new).and_return fake_importer
        fake_importer.should_receive(:import).with(filenames.call)

        XMLSplitter.stub(:new).and_return double(XMLSplitter).as_null_object

        importer.stub(:gunzip)

        importer.perform_import(FakeDownloader, FakeImporter, filenames, {})
      end

      context 'with skip download' do
      end
    end
  end
end
