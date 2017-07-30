module TripAdvisor
  class SFTP
    attr_reader :details

    def initialize(details:)
      @details = details
    end

    def download(remote, local)
      `USERNAME=#{username} HOST=#{host} REMOTE=#{remote} LOCAL=#{local} PASSWORD=#{password} bin/download_sftp`
    end

    private

    def host
      details.host
    end

    def username
      details.username
    end

    def password
      details.password
    end
  end
end
