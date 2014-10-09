require 'rails_helper'
require 'flip_key'

module FlipKey
  describe PropertyDownloader do
    let(:url_base) { 'http://ws.flipkey.com/pfe/' }
    let(:username) { 'mychaletfinder' }
    let(:password) { 'LIxoxLol' }
    let(:property_downloader) {
      PropertyDownloader.new(
        url_base: url_base, username: username, password: password
      )
    }

    describe '#download' do
      let(:basic_auth_downloader) { double(BasicAuthDownloader) }

      before do
        allow(BasicAuthDownloader)
          .to receive(:new)
          .and_return(basic_auth_downloader)
      end

      it 'fetches the property index' do
        allow(property_downloader).to receive(:parse_index).and_return([])

        expect(basic_auth_downloader)
          .to receive(:download)
          .with hash_including(
            from: url_base, to: property_downloader.index,
            username: username, password: password
          )

        property_downloader.download
      end

      it 'parses the property index' do
        allow(basic_auth_downloader).to receive(:download)

        expect(property_downloader).to receive(:parse_index).and_return []

        property_downloader.download
      end

      it 'downloads each property file' do
        allow(basic_auth_downloader).to receive(:download)
        allow(property_downloader).to receive(:parse_index).and_return ['1.xml.gz']

        expect(basic_auth_downloader)
          .to receive(:download)
          .with hash_including(
            from: url_base + '1.xml.gz', username: username, password: password,
            to: File.join(FlipKey.directory, '1.xml.gz')
          )

        property_downloader.download
      end

      it 'yields each property path' do
        class Receiver; end

        allow(basic_auth_downloader).to receive(:download)
        allow(property_downloader).to receive(:parse_index).and_return ['1.xml.gz']

        expect(Receiver)
          .to receive(:receive)
          .with('1.xml.gz')

        property_downloader.download do |path|
          Receiver.receive(path)
        end
      end
    end

    describe '#parse_index' do
      let(:file) { double(File) }

      it 'uses a PropertyIndexParser to parse the contents of the index' do
        index_parser = double(PropertyIndexParser)

        expect(File).to receive(:open).with(property_downloader.index) { |&block| block.yield file }
        expect(PropertyIndexParser).to receive(:new).with(file).and_return(index_parser)
        expect(index_parser).to receive(:parse)

        property_downloader.parse_index
      end
    end
  end
end
