require 'net/ftp'
require 'zlib'

module PierreEtVacances
  class FTP
    # Gets a ZIP file from the Pierre et Vacances FTP server corresponding to the given
    # XML file and unzips it.
    def self.get(remote_file)
      local_file = 'pierreetvacances/' + remote_file
      ftp_session do |ftp|
        ftp.getbinaryfile(remote_file, local_file)
      end
      unzip(local_file) if local_file[-4,4] == '.zip'
      begin
        File.unlink(local_zip_file)
      rescue
      end
    end

    def self.property_filename(summer_or_winter)
      unless [:summer, :winter].include? summer_or_winter
        raise ArgumentError.new "summer_or_winter must be :summer or :winter"
      end

      s_or_w = summer_or_winter == :summer ? 'E' : 'H'

      most_recent_file_matching "EN_PV_AA_#{s_or_w}13_GENERAL_*"
    end

    def self.most_recent_file_matching(glob)
      fn = ''
      ftp_session do |ftp|
        fn = most_recent_file(ftp.list glob).split.last
      end
      fn
    end

    def self.most_recent_file(list)
      list.sort_by {|fn| Date.parse(fn[-13, 9])}.last
    end

    def self.ftp_session
      ftp = Net::FTP.new
      ftp.connect('mutpv.pierreetvacances.com')
      ftp.login('b2c', 'B*u8MLe1')
      ftp.passive = true
      yield ftp
      ftp.close
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
