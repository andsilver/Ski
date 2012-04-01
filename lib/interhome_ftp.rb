require 'net/ftp'
require 'zlib'

class InterhomeFTP
  # Gets a ZIP file from the Interhome FTP server corresponding to the given
  # XML file and unzips it.
  def self.get(local_path)
    ftp = Net::FTP.new
    ftp.connect('ftp.interhome.com')
    ftp.login('ihxmlpartner', 'S13oPjEu')
    ftp.passive = true
    zip_file = local_path + '.zip'
    ftp.getbinaryfile(File.basename(zip_file), zip_file)
    ftp.close
    unzip(zip_file)
    begin
      File.unlink(zip_file)
    rescue
    end
  end

  protected

  def self.unzip(zip_file)
    `unzip -o #{zip_file}` # -o = overwrite existing files without prompting
  end
end
