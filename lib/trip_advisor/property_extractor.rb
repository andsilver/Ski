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

      extract_dir = path.gsub('.tar.gz', '')

      FileUtils.mkdir_p extract_dir

      `tar xzf #{path} -C #{extract_dir}`

      Dir[extract_dir + '/*'].each { |path| yield path } if block_given?
    end
  end
end
