require 'spec_helper'
require 'net/ftp'
require 'zlib'

describe InterhomeFTP do
  describe '.get' do
    let(:ftp) { mock('Net::FTP').as_null_object }

    before do
      InterhomeFTP.stub(:unzip)
      Net::FTP.stub(:new).and_return(ftp)
    end

    it 'connects to the Interhome FTP server' do
      Net::FTP.should_receive(:new).and_return(ftp)
      ftp.should_receive(:connect).with('ftp.interhome.com')
      InterhomeFTP.get('file')
    end

    it 'logs in' do
      ftp.should_receive(:login).with('ihxmlpartner', 'S13oPjEu')
      InterhomeFTP.get('file')
    end

    it 'switches to passive mode' do
      ftp.should_receive(:passive=).with(true)
      InterhomeFTP.get('file')
    end

    it 'gets the ZIP file corresponding to the file requested' do
      ftp.should_receive(:getbinaryfile).with('file.xml.zip', 'path/to/file.xml.zip')
      InterhomeFTP.get('path/to/file.xml')
    end

    it 'unzips the file' do
      InterhomeFTP.should_receive(:unzip).with('path/to/file.xml.zip')
      InterhomeFTP.get('path/to/file.xml')
    end

    it 'deletes the ZIP file' do
      File.should_receive(:unlink).with('path/to/file.xml.zip')
      InterhomeFTP.get('path/to/file.xml')
    end

    it 'closes the connection' do
      ftp.should_receive(:close)
      InterhomeFTP.get('file')
    end
  end
end
