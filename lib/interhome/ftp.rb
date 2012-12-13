require 'net/ftp'
require 'zlib'

module Interhome
  class FTP
    # Gets a ZIP file from the Interhome FTP server corresponding to the given
    # XML file and unzips it.
    def self.get(xml_file)
      ftp = Net::FTP.new
      ftp.connect('ftp.interhome.com')
      ftp.login('ihxmlpartner', 'S13oPjEu')
      ftp.passive = true
      zip_file = xml_file + '.zip'
      local_zip_file = 'interhome/' + zip_file
      ftp.getbinaryfile(zip_file, local_zip_file)
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
