module FlipKey
  class PropertyDownloader < Downloader
    # Returns the local path of the property index HTML file.
    def index
      File.join(FlipKey.directory, 'property_index.html')
    end
    
    # Parses the property index file and returns an array of property
    # filenames that can be fetched from +url_base+.
    def parse_index
      File.open(index) { |file| PropertyIndexParser.new(file).parse }
    end
  end
end
