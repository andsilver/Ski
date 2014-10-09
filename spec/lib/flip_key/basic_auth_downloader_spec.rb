require 'rails_helper'

module FlipKey
  describe BasicAuthDownloader do
    describe '#download' do
      let(:from)     { 'http://example.org/' }
      let(:to)       { 'test-files/basic-auth-download.txt' }
      let(:username) { 'user' }
      let(:password) { 'pass' }
      let(:body_str) { 'body...' }

      it 'uses basic authentation to download a file from a webserver' do
        curl_easy = double(Curl::Easy)
        expect(Curl::Easy).to receive(:new).with(from).and_return(curl_easy)
        expect(curl_easy).to receive(:http_auth_types=).with(:basic)
        expect(curl_easy).to receive(:username=).with(username)
        expect(curl_easy).to receive(:password=).with(password)
        expect(curl_easy).to receive(:perform)
        expect(curl_easy).to receive(:body_str).and_return(body_str)

        BasicAuthDownloader.new.download(
          from: from,
          to: to,
          username: username,
          password: password
        )

        expect(IO.read(to)).to eq body_str
        FileUtils.rm(to)
      end
    end
  end
end
