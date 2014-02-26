require 'spec_helper'

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
        Curl::Easy.should_receive(:new).with(from).and_return(curl_easy)
        curl_easy.should_receive(:http_auth_types=).with(:basic)
        curl_easy.should_receive(:username=).with(username)
        curl_easy.should_receive(:password=).with(password)
        curl_easy.should_receive(:perform)
        curl_easy.should_receive(:body_str).and_return(body_str)

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
