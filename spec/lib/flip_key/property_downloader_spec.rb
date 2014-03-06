require 'spec_helper'
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

    describe '#download_properties' do
      let(:basic_auth_downloader) { double(BasicAuthDownloader) }

      before do
        BasicAuthDownloader
          .stub(:new)
          .and_return(basic_auth_downloader)
      end

      it 'fetches the property index' do
        property_downloader.stub(:parse_index).and_return([])

        basic_auth_downloader
          .should_receive(:download)
          .with hash_including(
            from: url_base, to: property_downloader.index,
            username: username, password: password
          )

        property_downloader.download_properties
      end

      it 'parses the property index' do
        basic_auth_downloader.stub(:download)

        property_downloader.should_receive(:parse_index).and_return []

        property_downloader.download_properties
      end

      it 'downloads each property file' do
        basic_auth_downloader.stub(:download)
        property_downloader.stub(:parse_index).and_return ['1.xml.gz']

        basic_auth_downloader
          .should_receive(:download)
          .with hash_including(
            from: url_base + '1.xml.gz', username: username, password: password,
            to: File.join(FlipKey.directory, '1.xml.gz')
          )

        property_downloader.download_properties
      end

      it 'yields each property path' do
        class Receiver; end

        basic_auth_downloader.stub(:download)
        property_downloader.stub(:parse_index).and_return ['1.xml.gz']

        Receiver
          .should_receive(:receive)
          .with('1.xml.gz')

        property_downloader.download_properties do |path|
          Receiver.receive(path)
        end
      end
    end

    describe '#parse_index' do
      let(:file) { double(File) }

      it 'uses a PropertyIndexParser to parse the contents of the index' do
        index_parser = double(PropertyIndexParser)

        File.should_receive(:open).with(property_downloader.index) { |&block| block.yield file }
        PropertyIndexParser.should_receive(:new).with(file).and_return(index_parser)
        index_parser.should_receive(:parse)

        property_downloader.parse_index
      end
    end
  end
end
