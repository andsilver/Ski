module FlipKey
  class BasicAuthDownloader
    # Downloads a file from a webserver using basic authentication.
    def download(opts)
      opts.to_options!.assert_valid_keys(:from, :to, :username, :password)
      c = Curl::Easy.new(opts[:from])
      c.http_auth_types = :basic
      c.username        = opts[:username]
      c.password        = opts[:password]
      c.perform
      File.open(opts[:to], 'wb') { |f| f.write(c.body_str) }
    end
  end
end
