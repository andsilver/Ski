module TripAdvisor
  SFTPDetails = Struct.new(:host, :username, :password) {
    def self.default
      new(
        Rails.application.secrets.trip_advisor_host,
        Rails.application.secrets.trip_advisor_username,
        Rails.application.secrets.trip_advisor_password
      )
    end
  }
end
