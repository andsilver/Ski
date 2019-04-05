require "xmlsimple"

module Interhome
  class PlaceImporter
    XML_FILENAME = "countryregionplace_en.xml"

    def ftp_get
      FTP.get(XML_FILENAME)
    end

    # Deletes all existing Interhome places from the database and imports
    # places and subplaces (as places) from the XML file.
    def import
      InterhomePlace.delete_all
      xml_file = File.open(xml_filename, "rb")
      xml = XmlSimple.xml_in(xml_file)
      xml_file.close

      xml["country"].each {|c| import_country(c)} if xml
    end

    def import_country(c)
      country_name = c["name"][0].strip
      code = c["code"][0].strip
      c["regions"][0]["region"].each {|r| import_region(r, country_name, code)}
    end

    def import_region(r, name, code)
      region_name = r["name"][0].strip
      name = "#{name} > #{region_name}"
      if r["subregions"]
        r["subregions"][0]["subregion"].each {|sr| import_region(sr, name, code)}
      end

      code = "#{code}_#{r["code"][0]}"
      r["places"][0]["place"].each {|p| import_place(p, name, code)} unless r["places"].nil?
    end

    def import_place(p, name, code)
      # Interhome sometimes has unnamed places (maybe newly added & incomplete?)
      return if p["name"].nil?

      place_name = p["name"][0].strip
      name = "#{name} > #{place_name}"
      subcode = "#{code}_XXXX"
      code = "#{code}_#{p["code"][0].strip}"
      InterhomePlace.create!(code: code, name: place_name, full_name: name)
      p["subplaces"][0]["subplace"].each {|s| import_subplace(s, name, subcode)} unless p["subplaces"].nil?
    end

    def import_subplace(s, name, code)
      subplace_name = s["name"][0].strip
      name = "#{name} > #{subplace_name}"
      code = "#{code}_#{s["code"][0].strip}"
      InterhomePlace.create!(code: code, name: subplace_name, full_name: name)
    end

    def xml_filename
      "interhome/#{XML_FILENAME}"
    end
  end
end
