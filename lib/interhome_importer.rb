class InterhomeImporter
  def self.import(opts = {})
    opts = {
      skip_ftp: false,
      skip_places: false,
      skip_prices: false,
      max_xml_files: 0
    }.merge(opts)

    unless opts[:skip_places]
      @interhome_place_importer = InterhomePlaceImporter.new
      @interhome_place_importer.ftp_get unless opts[:skip_ftp]
      @interhome_place_importer.import
    end

    unless opts[:skip_prices]
      @interhome_price_importer = InterhomePriceImporter.new('2048', 7)
      @interhome_price_importer.ftp_get unless opts[:skip_ftp]
      filenames = @interhome_price_importer.split_xml(opts[:max_xml_files])
      @interhome_price_importer.import(filenames)
    end

    @interhome_description_importer = InterhomeDescriptionImporter.new('InterhomeInsideDescription')
    @interhome_description_importer.ftp_get unless opts[:skip_ftp]
    filenames = @interhome_description_importer.split_xml(opts[:max_xml_files])
    @interhome_description_importer.import(filenames)

    @interhome_description_importer = InterhomeDescriptionImporter.new('InterhomeOutsideDescription')
    @interhome_description_importer.ftp_get unless opts[:skip_ftp]
    filenames = @interhome_description_importer.split_xml(opts[:max_xml_files])
    @interhome_description_importer.import(filenames)

    @interhome_accommodation_importer = InterhomeAccommodationImporter.new
    @interhome_accommodation_importer.ftp_get unless opts[:skip_ftp]
    filenames = @interhome_accommodation_importer.split_xml(opts[:max_xml_files])
    @interhome_accommodation_importer.import(filenames, true)

    @interhome_vacancy_importer = InterhomeVancancyImporter.new
    @interhome_vacancy_importer.ftp_get unless opts[:skip_ftp]
    filenames = @interhome_vacancy_importer.split_xml(opts[:max_xml_files])
    @interhome_vacancy_importer.import(filenames)
  end
end
