module PierreEtVacances
  class Importer
    def self.import(opts = {})
      ftp = FTP.new
      ftp.get unless opts[:skip_ftp]
      accommodation_importer = AccommodationImporter.new
      accommodation_importer.import(
        [File.join('pierreetvacances/', ftp.xml_filename)]
      )
    end
  end
end
