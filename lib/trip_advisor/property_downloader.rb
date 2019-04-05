# frozen_string_literal: true

module TripAdvisor
  # Performs downloading of the property data files from the TripAdvisor SFTP
  # server.
  class PropertyDownloader
    def initialize(sftp_details:)
      @sftp_details = sftp_details
    end

    # Connects to the TripAdvisor SFTP server and downloads the gzipped listings
    # full listings file.
    # Returns the local path of the downloaded file.
    def download_full(date: Date.today - 1.day)
      mk_local_full_dir
      full_fn = full_filename(date)
      local = local_full_path(full_fn)

      sftp = SFTP.new(details: @sftp_details)
      sftp.download(remote_full_path(full_fn), local)

      local
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

    def full_filename(date)
      "listings_#{date.strftime("%Y%m%d")}.tar.gz"
    end

    def delta_filename(date)
      if date.cwday == 7
        date -= 1.day
      end
      "listings_delta_#{date.strftime("%Y%m%d")}.tar.gz"
    end

    def mk_local_full_dir
      mk(local_full_directory)
    end

    def mk_local_delta_dir
      mk(local_delta_directory)
    end

    def mk(dir)
      return if FileTest.exist?(dir)
      FileUtils.mkdir_p(dir)
    end

    def local_full_path(filename)
      File.join(local_full_directory, filename)
    end

    def local_delta_path(filename)
      File.join(local_delta_directory, filename)
    end

    def local_full_directory
      File.join(Rails.root, "trip_advisor", "listings")
    end

    def local_delta_directory
      File.join(local_full_directory, "delta")
    end

    def remote_full_path(filename)
      "/drop/listings/" + filename
    end

    def remote_delta_path(filename)
      "/drop/listings/delta/" + filename
    end
  end
end
