require 'net/ftp'
require 'zlib'

module PierreEtVacances
  class FTP
    # Gets a ZIP file from the Pierre et Vacances FTP server corresponding to the given
    # XML file and unzips it.
    def get
      local_file = 'pierreetvacances/' + xml_filename
      ftp_session do |ftp|
        ftp.getbinaryfile(xml_filename, local_file)
      end
      unzip(local_file) if local_file[-4,4] == '.zip'
      begin
        File.unlink(local_zip_file)
      rescue
      end
    end

    def xml_filename
      @xml_filename ||= property_filename
    end

    def property_filename
      s_or_w = current_season == :summer ? 'E' : 'H'
      most_recent_file_matching "EN_PV_AA_#{s_or_w}13_GENERAL_*"
    end

    def most_recent_file_matching(glob)
      fn = ''
      ftp_session do |ftp|
        fn = most_recent_file(ftp.list glob).split.last
      end
      fn
    end

    def most_recent_file(list)
      list.sort_by {|fn| Date.parse(fn[-13, 9])}.last
    end

    def ftp_session
      ftp = Net::FTP.new
      ftp.connect('mutpv.pierreetvacances.com')
      ftp.login('b2c', 'B*u8MLe1')
      ftp.passive = true
      yield ftp
      ftp.close
    end

    def current_season
      season(Date.today)
    end 

    def season(date)
      start_of_summer = Date.new(2000, 5, 1).yday
      start_of_winter = Date.new(2000, 9, 1).yday
      date = date.yday
      if start_of_summer <= date && date < start_of_winter
        :summer
      else
        :winter
      end
    end

    protected

    def unzip(zip_file)
      # -o = overwrite existing files without prompting
      `unzip -o #{zip_file} -d pierreetvacances`
    end

    def yesterday_date_string
      (Time.now - 1.day).strftime("%d%b%Y")
    end
  end
end
