module FlipKey
  class BasicAuthDownloader
    ERROR_LIMIT = 3

    # Downloads a file from a webserver using basic authentication.
    def download(opts)
      error_count = 0
      opts.to_options!.assert_valid_keys(:from, :to, :username, :password)
      begin
        Rails.logger.info "Downloading #{opts[:from]} to #{opts[:to]}..."
        c = Curl::Easy.new(opts[:from])
        c.http_auth_types = :basic
        c.username        = opts[:username]
        c.password        = opts[:password]
        c.perform
        File.open(opts[:to], 'wb') { |f| f.write(c.body_str) }
      rescue Curl::Err::PartialFileError => e
        error_count += 1
        Rails.logger.warn "Error downloading #{opts[:from]} to #{opts[:to]}: #{e}"
        if error_count == ERROR_LIMIT
          Rails.logger.error "Failure after #{ERROR_LIMIT} attempts: #{e}"
          raise
        else
          Rails.logger.warn "Retrying"
          retry
        end
      end
      Rails.logger.info "Downloaded #{opts[:from]} to #{opts[:to]}"
    end
  end
end
