module TripAdvisor
  # Extracts TripAdvisor listings from compressed archives.
  class PropertyExtractor
    attr_reader :path

    # Initialize with the path of the compressed archived file. You must ensure
    # that this path comes from a trusted source as no sanitization is applied.
    def initialize(path:)
      @path = path
    end

    # Extracts the archive and yields the path of each extracted file.
    def extract
      return unless FileTest.exist?(path)

      `tar xzf #{path} -C #{File.dirname(path)}`

      if block_given?
        extracted_dir = path.gsub('.tar.gz', '')
        Dir[extracted_dir + '/*'].each do |path|
          yield path
        end
      end
    end
  end
end
