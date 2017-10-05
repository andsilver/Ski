module TripAdvisor
  # Performs downloading of the property data files from the TripAdvisor SFTP
  # server.
  class PropertyDownloader
    def initialize(sftp_details:)
      @sftp_details = sftp_details
    end

    # Connects to the TripAdvisor SFTP server and downloads the gzipped listings
    # delta file.
    # Returns the local path of the downloaded file.
    def download_delta(date: Date.today - 1.day)
      mk_local_delta_dir
      delta_fn = delta_filename(date)
      local = local_delta_path(delta_fn)

      sftp = SFTP.new(details: @sftp_details)
      sftp.download(remote_delta_path(delta_fn), local)

      local
    end

    private

    def delta_filename(date)
      if date.cwday == 7
        date = date - 1.day
      end
      "listings_delta_#{date.strftime('%Y%m%d')}.tar.gz"
    end

    def mk_local_delta_dir
      return if FileTest.exist?(local_delta_directory)
      FileUtils.mkdir_p(local_delta_directory)
    end

    def local_delta_path(filename)
      File.join(local_delta_directory, filename)
    end

    def local_delta_directory
      File.join(Rails.root, 'trip_advisor', 'listings', 'delta')
    end

    def remote_delta_path(filename)
      '/drop/listings/delta/' + filename
    end
  end
end
