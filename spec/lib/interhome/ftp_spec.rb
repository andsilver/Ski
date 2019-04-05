require "rails_helper"
require "net/ftp"
require "zlib"

module Interhome
  describe FTP do
    describe ".get" do
      let(:ftp) { double("Net::FTP").as_null_object }

      before do
        allow(FTP).to receive(:unzip)
        allow(Net::FTP).to receive(:new).and_return(ftp)
      end

      it "connects to the Interhome FTP server" do
        expect(Net::FTP).to receive(:new).and_return(ftp)
        expect(ftp).to receive(:connect).with("ftp.interhome.com")
        FTP.get("file")
      end

      it "logs in" do
        expect(ftp).to receive(:login).with("ihxmlpartner", "XZpJ6LkG")
        FTP.get("file")
      end

      it "switches to passive mode" do
        expect(ftp).to receive(:passive=).with(true)
        FTP.get("file")
      end

      it "gets the ZIP file corresponding to the file requested" do
        expect(ftp).to receive(:getbinaryfile).with("file.xml.zip", "interhome/file.xml.zip")
        FTP.get("file.xml")
      end

      it "unzips the file" do
        expect(FTP).to receive(:unzip).with("interhome/file.xml.zip")
        FTP.get("file.xml")
      end

      it "deletes the ZIP file" do
        expect(File).to receive(:unlink).with("interhome/file.xml.zip")
        FTP.get("file.xml")
      end

      it "closes the connection" do
        expect(ftp).to receive(:close)
        FTP.get("file")
      end
    end
  end
end
