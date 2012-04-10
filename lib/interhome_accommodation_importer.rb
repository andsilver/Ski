require 'xmlsimple'

class InterhomeAccommodationImporter
  XML_FILENAME = 'accommodation.xml'

  def ftp_get
    InterhomeFTP.get(XML_FILENAME)
  end

  # Splits the large Interhome XML file into a number of smaller files and
  # returns an array of XML filenames. Set max_files to limit the number
  # of smaller files created (for example, when testing).
  def split_xml(max_files = 0)
    xs = XMLSplitter.new(:root_element => 'accommodations', :child_element => 'accommodation', :xml_filename => xml_filename, :elements_per_file => 500, :max_files => max_files)
    xs.split
  end

  # Deletes all existing Interhome accommodations from the database and imports
  # accommodations from the XML file.
  def import(filenames)
    @interhome = User.find_by_email('interhome@mychaletfinder.com')
    raise 'A user with email interhome@mychaletfinder.com is required' unless @interhome

    @default_resort = Resort.find_by_name('Interhome')
    raise 'A resort with name Interhome is required' unless @default_resort

    @euro = Currency.find_by_code('EUR')
    raise 'A currency with code EUR is required' unless @euro

    @interhome.adverts.delete_all
    InterhomeAccommodation.destroy_all
    filenames.each {|f| import_file(f)}
  end

  def import_file(filename)
    xml_file = File.open(filename, 'rb')
    xml = XmlSimple.xml_in(xml_file)
    xml_file.close

    xml['accommodation'].each {|a| import_accommodation(a)} if xml
  end

  def import_accommodation(a)
    return if a['details'][0] != 'C' # only import chalets
    return if a['brand'][0] != 'I' # only import Interhome products

    accommodation = InterhomeAccommodation.new
    accommodation.code = a['code'][0]
    accommodation.name = a['name'][0]
    accommodation.name = '' unless accommodation.name.kind_of?(String)
    accommodation.country = a['country'][0]
    accommodation.region = a['region'][0]
    accommodation.place = a['place'][0]
    accommodation.zip = a['zip'][0]
    accommodation.accommodation_type = a['type'][0]
    accommodation.details = a['details'][0]
    accommodation.quality = a['quality'][0]
    accommodation.brand = a['brand'][0]
    accommodation.pax = a['pax'][0]
    accommodation.sqm = a['sqm'] ? a['sqm'][0] : 0
    accommodation.floor = a['floor'][0]
    accommodation.rooms = a['rooms'][0]
    accommodation.bedrooms = a['bedrooms'][0]
    accommodation.bathrooms = a['bathrooms'] ? a['bathrooms'][0] : 0
    accommodation.toilets = a['toilets'] ? a['toilets'][0] : 0
    accommodation.features = features(a)
    if a['geodata']
      accommodation.geodata_lat = a['geodata'][0]['lat'][0]
      accommodation.geodata_lng = a['geodata'][0]['lng'][0]
    else
      accommodation.geodata_lat = accommodation.geodata_lng = ''
    end
    accommodation.themes = themes(a)
    accommodation.permalink = PermalinkFu.escape(accommodation.code)
    accommodation.save

    import_pictures(accommodation, a)
    create_property(accommodation)
  end

  def import_pictures(accommodation, a)
    a['pictures'][0]['picture'].each do |p|
      picture = InterhomePicture.new
      picture.picture_type = p['type'][0]
      picture.season = p['season'][0]
      picture.url = p['url'][0].gsub('/Normal/', '/Zoom/')
      accommodation.interhome_pictures << picture
    end
  end

  def create_property(accommodation)
    place = InterhomePlace.find_by_country_and_region_and_place(accommodation.country, accommodation.region, accommodation.place)
    return unless place

    ipr = InterhomePlaceResort.find_by_interhome_place_code(place.code)

    property = Property.new
    property.interhome_accommodation_id = accommodation.id
    property.user_id = @interhome.id
    property.resort_id = ipr ? ipr.resort_id : @default_resort.id
    property.name = accommodation.name.blank? ? accommodation.code : accommodation.name
    property.strapline = accommodation.inside_description[0..254]
    property.address = place.name
    property.weekly_rent_price = accommodation.current_price
    return if property.weekly_rent_price.nil?
    property.currency_id = @euro.id
    return unless property.save

    accommodation.interhome_pictures.each do |picture|
      image = Image.new
      image.user_id = @interhome.id
      image.source_url = picture.url
      image.property_id = property.id
      image.save

      if picture.picture_type == 'm'
        property.image_id = image.id
        property.save
      end
    end

    advert = Advert.new
    advert.user_id = @interhome.id
    advert.property_id = property.id
    advert.starts_at = Time.now
    advert.expires_at = Time.now + 10.years
    advert.months = 120
    advert.save
  end

  def themes(a)
    return '' unless a['themes']
    themes = []
    a['themes'][0]['theme'].each {|t| themes << t}
    themes.join(',')
  end

  def features(a)
    return '' unless a['attributes']
    features = []
    a['attributes'][0]['attribute'].each {|f| features << f}
    features.join(',')
  end

  def xml_filename
    "interhome/#{XML_FILENAME}"
  end
end
