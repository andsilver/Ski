module FlipKey
  class Downloader
    # The +opts+ hash should contain +url_base+, +username+ and +password+.
    def initialize(opts)
      @url_base = opts[:url_base]
      @username = opts[:username]
      @password = opts[:password]
    end

    # Downloads data files from the FlipKey webserver and yields each
    # filename.
    def download
      downloader = BasicAuthDownloader.new
      downloader.download(from: index_url_base, to: index, username: @username, password: @password)

      background_process(parse_index) do |filename|
        downloader.download(
          from: index_url_base + filename,
          to: File.join(FlipKey.directory, filename),
          username: @username, password: @password
        )
        yield filename if block_given?
      end
    end

    # Returns the local path of the data index HTML file.
    def index
      raise 'Implementation required from subclass'
    end
    
    # Parses the index file and returns an array of
    # filenames that can be fetched from +index_url_base+.
    def parse_index
      raise 'Implementation required from subclass'
    end

    def index_url_base
      @url_base
    end

    private

      def background_process(items)
        queue = Queue.new
        items.each { |item| queue << item }
        threads = []

        4.times do
          threads << Thread.new do
            until queue.empty?
              item = queue.pop(true) rescue nil
              yield item
            end
            ActiveRecord::Base.clear_active_connections!
          end
        end

        threads.each(&:join)
      end
  end
end
