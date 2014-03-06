module FlipKey
  class PropertyDownloader
    # The +opts+ hash should contain +url_base+, +username+ and +password+.
    def initialize(opts)
      @url_base = opts[:url_base]
      @username = opts[:username]
      @password = opts[:password]
    end

    # Downloads all property files from the FlipKey webserver.
    def download_properties
      downloader = BasicAuthDownloader.new
      downloader.download(from: @url_base, to: index, username: @username, password: @password)

      background_process(parse_index) do |property_filename|
        property_path = File.join(flip_key_directory, property_filename)
        downloader.download(
          from: @url_base + property_filename,
          to: property_path,
          username: @username, password: @password
        )
      end
    end

    # Returns the local path of the property index HTML file.
    def index
      File.join(flip_key_directory, 'property_index.html')
    end

    # Returns the directory where FlipKey data files are stored locally.
    def flip_key_directory
      'flip_key'
    end
    
    # Parses the property index file and returns an array of property
    # filenames that can be fetched from +url_base+.
    def parse_index
      File.open(index) { |file| PropertyIndexParser.new(file).parse }
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
            ActiveRecord::Base.connection.close
          end
        end

        threads.each(&:join)
      end
  end
end
