require 'net/ftp'
require 'zlib'

module PierreEtVacances
  class FTP
    # Gets a ZIP file from the Pierre et Vacances FTP server corresponding to the given
    # XML file and unzips it.
    def self.get(remote_file)
      ftp = Net::FTP.new
      ftp.connect('mutpv.pierreetvacances.com')
      ftp.login('b2c', 'B*u8MLe1')
      ftp.passive = true
      local_file = 'pierreetvacances/' + remote_file
      ftp.getbinaryfile(remote_file, local_file)
      ftp.close
      unzip(local_file) if local_file[-4,4] == '.zip'
      begin
        File.unlink(local_zip_file)
      rescue
      end
    end

    def self.property_file(summer_or_winter)
      unless [:summer, :winter].include? summer_or_winter
        raise ArgumentError.new"summer_or_winter must be :summer or :winter"
      end

      s_or_w = summer_or_winter == :summer ? 'E' : 'H'

      "EN_PV_AA_#{s_or_w}13_GENERAL_#{yesterday_date_string}.xml"
    end

    protected

    def self.unzip(zip_file)
      # -o = overwrite existing files without prompting
      `unzip -o #{zip_file} -d pierreetvacances`
    end

    def self.yesterday_date_string
      (Time.now - 1.day).strftime("%d%b%Y")
    end
  end
end
