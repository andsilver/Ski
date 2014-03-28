module FlipKey
  class Importer
    DOWNLOADER_OPTIONS = {
      url_base: 'http://ws.flipkey.com/pfe/',
      username: 'mychaletfinder',
      password: 'LIxoxLol'
    }.freeze

    PROPERTY_XML_SPLIT_OPTIONS = {
      root_element: 'property_data',
      child_element: 'property',
      elements_per_file: 75
    }.freeze

    def initialize(options = {})
      @options = options.reverse_merge! skip_download: false
    end

    # Imports all FlipKey data.
    def import
      import_properties
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
          opts = { xml_filename: xml_filename }.merge PROPERTY_XML_SPLIT_OPTIONS
          splitter = XMLSplitter.new(opts)
          splitter.split
        end
      end

      importer.new.import(filenames.call)
    end

    private

      def filenames_matching(pattern)
        Dir.entries(FlipKey.directory).select { |e| e =~ pattern }
      end

      def gunzip(filename)
        system("gunzip -f #{File.join(FlipKey.directory, filename)}")
      end
  end
end
