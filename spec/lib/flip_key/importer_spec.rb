require 'rails_helper'
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
        allow(importer).to receive(:import_properties)
        expect(importer).to receive(:import_locations)
        importer.import
      end

      it 'imports properties' do
        allow(importer).to receive(:import_locations)
        expect(importer).to receive(:import_properties)
        importer.import
      end

      it 'destroys stale properties' do
        allow(importer).to receive(:import_locations)
        allow(importer).to receive(:import_properties)

        expect(FlipKeyProperty).to receive(:destroy_stale)
        importer.import
      end
    end

    describe '#import_properties' do
      it 'calls perform_import with property import settings' do
        expect(importer)
          .to receive(:perform_import)
          .with(PropertyDownloader, PropertyImporter, anything(), Importer::PROPERTY_XML_SPLIT_OPTIONS)
        importer.import_properties
      end
    end

    describe '#property_filenames' do
      it 'returns an array of splitted property XML filenames, including the FlipKey directory' do
        allow(Dir).to receive(:entries).with(FlipKey.directory).and_return(dir_entries)
        expect(importer.property_filenames).to eq [File.join(FlipKey.directory, 'property_data_13.10.xml')]
      end
    end

    class FakeImporter
      def import(x); end
    end

    describe '#perform_import' do
      class FakeDownloader
        def initialize(x); end

        def download
          yield 'data.xml.gz'
        end
      end

      let(:filenames) { -> { ['data1.xml'] } }

      it 'creates a downloader and requests download' do
        downloader = double(FakeDownloader)
        expect(FakeDownloader).to receive(:new).and_return(downloader)
        expect(downloader).to receive(:download)

        importer.perform_import(FakeDownloader, FakeImporter, filenames, {})
      end

      it 'gunzips filenames yielded by the downloader' do
        allow(XMLSplitter).to receive(:new).and_return double(XMLSplitter).as_null_object
        expect(importer).to receive(:gunzip).with('data.xml.gz')
        importer.perform_import(FakeDownloader, FakeImporter, filenames, {})
      end

      it 'splits the large XML files into smaller ones' do
        xml_splitter = double(XMLSplitter)
        expect(XMLSplitter)
          .to receive(:new)
          .with({ xml_filename: File.join(FlipKey.directory, 'data.xml') }.merge Importer::PROPERTY_XML_SPLIT_OPTIONS)
          .and_return(xml_splitter)
        expect(xml_splitter).to receive(:split)

        allow(importer).to receive(:gunzip)

        importer.perform_import(FakeDownloader, FakeImporter, filenames, Importer::PROPERTY_XML_SPLIT_OPTIONS)
      end
    end

    describe '#perform_import_without_download' do
      let(:filenames) { -> { ['data1.xml'] } }

      it 'creates an importer and requests it to import the filenames' do
        fake_importer = double(FakeImporter)
        expect(FakeImporter).to receive(:new).and_return fake_importer
        expect(fake_importer).to receive(:import).with(filenames.call)

        allow(XMLSplitter).to receive(:new).and_return double(XMLSplitter).as_null_object

        importer.perform_import_without_download(FakeImporter, filenames)
      end
    end

    describe '#import_and_delete' do
      let(:filenames) {[
        File.join('tmp', SecureRandom.hex), File.join('tmp', SecureRandom.hex)
      ]}

      it 'imports each filename' do
        fake_importer = double(FakeImporter)
        expect(FakeImporter).to receive(:new).and_return fake_importer
        expect(fake_importer).to receive(:import).with(filenames)
        Importer.new.import_and_delete(FakeImporter, filenames)
      end

      it 'deletes each file' do
        filenames.each do |f|
          FileUtils.touch(f)
          expect(File.exist?(f)).to be_truthy
        end

        Importer.new.import_and_delete(FakeImporter, filenames)

        filenames.each do |f|
          expect(File.exist?(f)).to be_falsey
        end
      end
    end
  end
end
