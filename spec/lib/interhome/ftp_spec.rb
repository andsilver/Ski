require 'spec_helper'
require 'net/ftp'
require 'zlib'

module Interhome
  describe FTP do
    describe '.get' do
      let(:ftp) { double('Net::FTP').as_null_object }

      before do
        FTP.stub(:unzip)
        Net::FTP.stub(:new).and_return(ftp)
      end

      it 'connects to the Interhome FTP server' do
        Net::FTP.should_receive(:new).and_return(ftp)
        ftp.should_receive(:connect).with('ftp.interhome.com')
        FTP.get('file')
      end

      it 'logs in' do
        ftp.should_receive(:login).with('ihxmlpartner', 'S13oPjEu')
        FTP.get('file')
      end

      it 'switches to passive mode' do
        ftp.should_receive(:passive=).with(true)
        FTP.get('file')
      end

      it 'gets the ZIP file corresponding to the file requested' do
        ftp.should_receive(:getbinaryfile).with('file.xml.zip', 'interhome/file.xml.zip')
        FTP.get('file.xml')
      end

      it 'unzips the file' do
        FTP.should_receive(:unzip).with('interhome/file.xml.zip')
        FTP.get('file.xml')
      end

      it 'deletes the ZIP file' do
        File.should_receive(:unlink).with('interhome/file.xml.zip')
        FTP.get('file.xml')
      end

      it 'closes the connection' do
        ftp.should_receive(:close)
        FTP.get('file')
      end
    end
  end
end
