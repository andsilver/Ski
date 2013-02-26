module PierreEtVacances
  class Importer
    def self.import(opts = {})
      @accommodation_importer = AccommodationImporter.new
      @accommodation_importer.ftp_get unless opts[:skip_ftp]
      @accommodation_importer.import(['pierreetvacances/' + @accommodation_importer.xml_filename], true)
    end
  end
end
