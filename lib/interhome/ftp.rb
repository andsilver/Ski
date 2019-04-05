require "net/ftp"
require "zlib"

module Interhome
  class FTP
    # Gets a ZIP file from the Interhome FTP server corresponding to the given
    # XML file and unzips it.
    def self.get(xml_file)
      ftp = Net::FTP.new
      ftp.connect("ftp.interhome.com")
      ftp.login("ihxmlpartner", "XZpJ6LkG")
      ftp.passive = true
      zip_file = xml_file + ".zip"
      local_zip_file = "interhome/" + zip_file

      begin
        ftp.getbinaryfile(zip_file, local_zip_file)
      rescue Net::FTPPermError => e
        Rails.logger.error(
          "Failed to FTP get file #{zip_file} (#{e.message.tr("\n", "")})"
        )
        raise
      end

      ftp.close
      unzip(local_zip_file)
      begin
        File.unlink(local_zip_file)
      rescue
      end
    end

    protected

    def self.unzip(zip_file)
      `unzip -o #{zip_file} -d interhome` # -o = overwrite existing files without prompting
    end
  end
end
