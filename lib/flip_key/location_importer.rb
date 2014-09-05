require 'xmlsimple'

module FlipKey
  class LocationImporter
    def import(filenames)
      filenames.each {|f| import_filename(f)}
    end

    def import_filename(f)
      xml_file = File.open(f, 'rb')
      xml = XmlSimple.xml_in(xml_file)
      xml_file.close

      xml['location'].each {|l| import_location(l)} if xml
    end

    def import_location(l)
      return if l['display'][0].kind_of? Hash
      id = l['location_id']
      location = FlipKeyLocation.find_by(id: id) || FlipKeyLocation.new
      location.id = id
      location.name = l['display'][0].strip
      location.lft = l['lft'][0].strip
      location.rgt = l['rgt'][0].strip
      location.parent_path = l['parent_path'][0].strip
      location.parent_id = l['parent_location_id'][0].strip
      location.property_count = l['property_count'][0].strip unless l['property_count'][0].kind_of? Hash
      location.save
    end
  end
end
