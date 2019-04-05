module TripAdvisor
  # Performs downloading of the location data file from the TripAdvisor SFTP
  # server.
  class LocationDownloader
    attr_reader :host, :username, :password

    def initialize(sftp_details:)
      @host = sftp_details.host
      @username = sftp_details.username
      @password = sftp_details.password
    end

    # Connects to the TripAdvisor SFTP server and downloads locations.json.
    def download
      Rails.logger.info(
        "Beginning TripAdvisor location download of #{remote_path} to " \
        "#{self.class.local_path}"
      )
      Net::SFTP.start(host, username, password: password) do |sftp|
        sftp.download!(remote_path, self.class.local_path)
      end
      Rails.logger.info("Finished downloading TripAdvisor location file")
    end

    # Path to the locally downloaded copy of the locations.json data file.
    def self.local_path
      File.join(Rails.root, "trip_advisor", "locations.json")
    end

    private

    def remote_path
      "/drop/locations/locations.json"
    end
  end
end
