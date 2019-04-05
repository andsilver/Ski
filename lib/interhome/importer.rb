module Interhome
  class Importer
    def initialize(opts = {})
      @opts = {
        skip_ftp: false,
        skip_places: false,
        skip_prices: false,
        max_xml_files: 0,
      }.merge(opts)
    end

    def skip_ftp?
      @opts[:skip_ftp]
    end

    def import
      import_places unless @opts[:skip_places]

      import_prices unless @opts[:skip_prices]

      import_descriptions("InterhomeInsideDescription")

      import_descriptions("InterhomeOutsideDescription")

      import_accommodation

      import_vacancies
    end

    def import_places
      importer = PlaceImporter.new
      importer.ftp_get unless skip_ftp?
      importer.import
    end

    def import_prices
      importer = PriceImporter.new("3535", 7)
      importer.ftp_get unless skip_ftp?
      filenames = importer.split_xml(@opts[:max_xml_files])
      importer.import(filenames)
    end

    def import_descriptions(class_name)
      importer = DescriptionImporter.new(class_name)
      importer.ftp_get unless skip_ftp?
      filenames = importer.split_xml(@opts[:max_xml_files])
      importer.import(filenames)
    end

    def import_accommodation
      importer = AccommodationImporter.new
      importer.ftp_get unless skip_ftp?
      filenames = importer.split_xml(@opts[:max_xml_files])
      importer.import(filenames)
      importer.cleanup
    end

    def import_vacancies
      importer = VacancyImporter.new
      importer.ftp_get unless skip_ftp?
      filenames = importer.split_xml(@opts[:max_xml_files])
      importer.import(filenames)
    end

    def self.import_local_accommodation_only
      importer = AccommodationImporter.new
      filenames = Dir.entries("interhome")
        .select { |e| e =~ /\Aaccommodation\.\d+\.xml\z/ }
        .map    { |f| "interhome/#{f}" }
      importer.import(filenames)
      importer.cleanup
    end
  end
end
