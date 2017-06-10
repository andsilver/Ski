module TripAdvisor
  # Performs downloading of the location data file from the TripAdvisor SFTP
  # server.
  class LocationDownloader
    attr_reader :host, :username, :password

    def initialize(host:, username:, password:)
      @host = host
      @username = username
      @password = password
    end

    # Connects to the TripAdvisor SFTP server and downloads locations.json.
    def download
      Net::SFTP.start(host, username, password: password) do |sftp|
        sftp.download!(remote_path, self.class.local_path)
      end
    end

    # Path to the locally downloaded copy of the locations.json data file.
    def self.local_path
      File.join(Rails.root, 'trip_advisor', 'locations.json')
    end

    private

    def remote_path
      '/drop/locations/locations.json'
    end
  end
end
