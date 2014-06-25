module FlipKey
  class Importer
    DOWNLOADER_OPTIONS = {
      url_base: 'http://ws.flipkey.com/pfe/',
      username: 'mychaletfinder',
      password: 'LIxoxLol'
    }.freeze

    LOCATION_XML_SPLIT_OPTIONS = {
      root_element: 'locations',
      child_element: 'location',
      elements_per_file: 4000
    }.freeze

    PROPERTY_XML_SPLIT_OPTIONS = {
      root_element: 'property_data',
      child_element: 'property',
      elements_per_file: 100
    }.freeze

    # Set +:limit_filenames+ to perform a smaller import during development.
    def initialize(options = {})
      @options = options.reverse_merge! skip_download: false, limit_filenames: -1
    end

    # Imports all FlipKey data.
    def import
      import_locations
      import_properties
    end

    # Imports FlipKey location data.
    def import_locations
      perform_import(
        LocationDownloader,
        LocationImporter,
        -> { location_filenames },
        LOCATION_XML_SPLIT_OPTIONS
      )
    end

    # Imports FlipKey property data.
    def import_properties
      perform_import(
        PropertyDownloader,
        PropertyImporter,
        -> { property_filenames },
        PROPERTY_XML_SPLIT_OPTIONS
      )
    end

    # Returns an array of location XML filenames.
    def location_filenames
      filenames_matching(/\A\d+[a-z_]+\.\d+\.xml\z/)
    end

    # Returns an array of property XML filenames.
    def property_filenames
      filenames_matching(/\Aproperty_data_\d+\.\d+\.xml\z/)
    end

    # Instantiates +importer+ and invokes its import method on +filenames+.
    # +filenames+ is a lambda that is called after the download process.
    # The download process is skipped if the importer is initialised with the
    # +skip_download+ option.
    def perform_import(downloader, importer, filenames, xml_split_options)
      unless @options[:skip_download]
        downloader.new(DOWNLOADER_OPTIONS).download do |filename|
          gunzip(filename)
          xml_filename = File.join(FlipKey.directory, filename[0..-4])
          opts = { xml_filename: xml_filename }.merge xml_split_options
          splitter = XMLSplitter.new(opts)
          splitter.split
        end
      end

      importer.new.import(limit_filenames(filenames))
    end

    private

      def filenames_matching(pattern)
        Dir.entries(FlipKey.directory).select { |e| e =~ pattern }
      end

      def gunzip(filename)
        system("gunzip -f #{File.join(FlipKey.directory, filename)}")
      end

      def limit_filenames(filenames_lambda)
        filenames = filenames_lambda.call
        if @options[:limit_filenames] > 0
          filenames[0...(@options[:limit_filenames])]
        else
          filenames
        end
      end
  end
end
