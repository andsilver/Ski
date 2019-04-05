require "xmlsimple"

module Interhome
  class VacancyImporter
    XML_FILENAME = "vacancy.xml"

    def ftp_get
      FTP.get(XML_FILENAME)
    end

    # Splits the large Interhome XML file into a number of smaller files and
    # returns an array of XML filenames. Set max_files to limit the number
    # of smaller files created (for example, when testing).
    def split_xml(max_files = 0)
      xs = XMLSplitter.new(root_element: "vacancies", child_element: "vacancy", xml_filename: xml_filename, elements_per_file: 1000, max_files: max_files)
      xs.split
    end

    # Deletes all existing Interhome vacancies from the database and imports
    # new vacancies from the XML file.
    def import(filenames)
      InterhomeVacancy.delete_all
      filenames.each {|f| import_file(f)}
    end

    protected

    def import_file(filename)
      xml_file = File.open(filename, "rb")
      xml = XmlSimple.xml_in(xml_file)
      xml_file.close

      xml["vacancy"].each {|v| import_vacancy(v)} if xml
    end

    def import_vacancy(v)
      vacancy = InterhomeVacancy.new
      vacancy.accommodation_code = v["code"][0]
      accommodation = InterhomeAccommodation.find_by(code: vacancy.accommodation_code)
      return unless accommodation

      vacancy.interhome_accommodation_id = accommodation.id
      vacancy.startday = v["startday"][0]
      vacancy.availability = v["availability"][0]
      vacancy.changeover = v["changeover"][0]
      vacancy.minstay = v["minstay"][0]
      vacancy.flexbooking = v["flexbooking"][0]
      vacancy.save
    end

    def xml_filename
      "interhome/#{XML_FILENAME}"
    end
  end
end
