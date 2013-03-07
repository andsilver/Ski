require 'xmlsimple'

module PierreEtVacances
  class VacancyImporter
    def base_filename
      FTP.most_recent_file_matching('DISPO_B2C_*').gsub('.zip', '')
    end

    def zip_filename
      base_filename + '.zip'
    end

    def csv_filename
      base_filename + '.csv'
    end

    def ftp_get
      FTP.get(zip_filename)
    end

    # Deletes all existing Pierre et Vacances vacancies from the database and
    # imports new vacancies from the CSV file.
    def import
      PvVacancy.delete_all
      `split -l 100000 pierreetvacances/#{csv_filename} pierreetvacances/vacancy.csv.`
      Dir.entries('pierreetvacances').select {|e| e.include?("vacancy.csv.")}.each do |csv|
        import_file('pierreetvacances/' + csv)
      end
      `rm pierreetvacances/vacancy.csv.*`
    end

    protected

    def import_file(filename)
      require 'csv'
      CSV.parse(File.open(filename), col_sep: ';').each do |row|
        v = PvVacancy.create(
        destination_code: row[0],
        apartment_code: row[1],
        typology: row[2],
        start_date: row[3],
        duration: row[4],
        stock_quantity: row[5],
        base_price: row[6],
        promo_price_fr: row[7],
        promo_price_en: row[8],
        promo_price_de: row[9],
        promo_price_nl: row[10],
        promo_price_es: row[11],
        promo_price_it: row[12]
        )
      end
      return
      xml_file = File.open(filename, 'rb')
      xml = XmlSimple.xml_in(xml_file)
      xml_file.close

      xml['vacancy'].each {|v| import_vacancy(v)} if xml
    end

    def import_vacancy(v)
      vacancy = InterhomeVacancy.new
      vacancy.accommodation_code = v['code'][0]
      accommodation = InterhomeAccommodation.find_by_code(vacancy.accommodation_code)
      return unless accommodation

      vacancy.interhome_accommodation_id = accommodation.id
      vacancy.startday = v['startday'][0]
      vacancy.availability = v['availability'][0]
      vacancy.changeover = v['changeover'][0]
      vacancy.minstay = v['minstay'][0]
      vacancy.flexbooking = v['flexbooking'][0]
      vacancy.save
    end
  end
end
