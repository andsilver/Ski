module FlipKey
  class LocationDownloader < Downloader
    # Returns the local path of the property index HTML file.
    def index
      File.join(FlipKey.directory, 'location_index.html')
    end
    
    # Parses the location index file and returns an array of location
    # filenames that can be fetched from +location_url_base+.
    def parse_index
      File.open(index) { |file| LocationIndexParser.new(file).parse }
    end

    def index_url_base
      @url_base + 'locations/'
    end
  end
end
