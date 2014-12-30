require_relative '../xml_splitter.rb'

module FlipKey
  class Importer
    DOWNLOADER_OPTIONS = {
      url_base: 'https://ws.flipkey.com/pfe/',
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
      elements_per_file: 250
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

    # Performs an import. 
    #
    # The download process is skipped if FlipKey::Importer is initialised with
    # the +skip_download+ option.
    #
    # * <tt>importer</tt> is a class to perform the import.
    #
    # When downloading:
    #
    # * <tt>downloader</tt> is a class to perform the download.
    # * <tt>filenames</tt> is ignored. Files are imported as they are downloaded
    # and processed.
    # * <tt>xml_split_options</tt> are passed to the XML splitter.
    #
    # When skipping download:
    # * <tt>filenames</tt> is a lambda that should return files to be imported.
    # * <tt>downloader</tt> and <tt>xml_split_options</tt> are ignored.
    def perform_import(downloader, importer, filenames, xml_split_options)
      if @options[:skip_download]
        perform_import_without_download(importer, filenames)
      else
        perform_import_with_download(downloader, importer, xml_split_options)
      end
    end

    def perform_import_with_download(downloader, importer, xml_split_options)
      prepare(downloader, xml_split_options) do |filename|
        Rails.logger.info "FlipKey::Importer: queuing import and deletion of #{filename}..."
        delay.import_and_delete(importer, [filename])
      end
    end

    def perform_import_without_download(importer, filenames)
      importer.new.import(limit_filenames(filenames))
    end

    # Imports the given array of filenames and deletes the files on completion.
    def import_and_delete(importer, filenames)
      importer.new.import(filenames)
      filenames.each { |f| FileUtils.safe_unlink(f) }
    end

    # Downloads and prepares files ready for importing.
    def prepare(downloader, xml_split_options, &block)
      downloader.new(DOWNLOADER_OPTIONS).download do |filename|
        gunzip(filename)
        xml_filename = File.join(FlipKey.directory, filename[0..-4])
        opts = { xml_filename: xml_filename }.merge xml_split_options
        splitter = ::XMLSplitter.new(opts)
        splitter.split(&block)
      end      
    end

    private

      def filenames_matching(pattern)
        Dir.entries(FlipKey.directory)
          .select { |e| e =~ pattern }
          .map {|f| File.join(FlipKey.directory, f)}
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
