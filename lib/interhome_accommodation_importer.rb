# coding: utf-8

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
    xs = XMLSplitter.new(root_element: 'accommodations', child_element: 'accommodation', xml_filename: xml_filename, elements_per_file: 500, max_files: max_files)
    xs.split
  end

  # Non-destructive import.
  # Updates existing Interhome accommodations and imports new accommodations
  # from the XML file.
  # Old accommodations are destroyed by checking their updated_at timestamps.
  def import(filenames, cleanup)
    setup
    filenames.each {|f| import_file(f)}
    if cleanup
      delete_old_adverts
      InterhomeAccommodation.destroy_all(['updated_at < ?', @import_start_time])
    end
  end

  def setup
    @interhome = User.find_by_email('interhome@mychaletfinder.com')
    raise 'A user with email interhome@mychaletfinder.com is required' unless @interhome

    @default_resort = Resort.find_by_name('Interhome')
    raise 'A resort with name Interhome is required' unless @default_resort

    @euro = Currency.find_by_code('EUR')
    raise 'A currency with code EUR is required' unless @euro

    @import_start_time = Time.now
  end

  def delete_old_adverts
    Advert.delete_all(['user_id = ? AND updated_at < ?', @interhome.id, @import_start_time])
  end

  # Imports a single XML file. Property geocoding is suspended for the
  # duration of the file's import.
  def import_file(filename)
    xml_file = File.open(filename, 'rb')
    xml = XmlSimple.xml_in(xml_file)
    xml_file.close

    Property.stop_geocoding
    xml['accommodation'].each {|a| import_accommodation(a)} if xml
    Property.resume_geocoding
  end

  def import_accommodation(a)
    return unless import_details?(a['details'][0])
    return if a['brand'][0] != 'I' && a['brand'][0] != 'M' # only import Interhome products

    accommodation = InterhomeAccommodation.find_by_code(a['code'][0])
    if accommodation
      # ensure the updated_at timestamp is updated
      # the save later won't touch the database if all attributes remain unchanged
      accommodation.touch
    else
      accommodation = InterhomeAccommodation.new
    end
    accommodation.code = a['code'][0]
    accommodation.name = a['name'][0]
    accommodation.name = '' unless accommodation.name.kind_of?(String)
    accommodation.country = a['country'][0]
    accommodation.region = a['region'][0]
    accommodation.place = a['place'][0]
    accommodation.zip = a['zip'] ? a['zip'][0] : '' # some countries (e.g. RoI) don't use postal codes
    accommodation.accommodation_type = a['type'][0]
    accommodation.details = a['details'][0]
    accommodation.quality = a['quality'][0]
    accommodation.brand = a['brand'][0]
    accommodation.pax = a['pax'] ? a['pax'][0] : 0
    accommodation.sqm = a['sqm'] ? a['sqm'][0] : 0
    accommodation.floor = a['floor'] ? a['floor'][0] : 0
    accommodation.rooms = a['rooms'] ? a['rooms'][0] : 0
    accommodation.bedrooms = a['bedrooms'] ? a['bedrooms'][0] : 0
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
    accommodation.permalink = accommodation.code.parameterize
    accommodation.save

    import_pictures(accommodation, a)
    delete_old_pictures(accommodation)
    create_property(accommodation)
  end

  # Imports pictures for the new or existing accommodation.
  # Touch (update timestamp of) existing pictures and add new ones.
  def import_pictures(accommodation, a)
    a['pictures'][0]['picture'].each do |p|
      url = p['url'][0].gsub('/Normal/', '/Zoom/')
      picture = InterhomePicture.find_by_interhome_accommodation_id_and_url(accommodation.id, url)
      if picture
        picture.touch
      else
        picture = InterhomePicture.new
        picture.picture_type = p['type'][0]
        picture.season = p['season'][0]
        picture.url = url
        accommodation.interhome_pictures << picture
      end
    end
  end

  # Delete old pictures that have been imported before but aren't mentioned
  # in the current XML file.
  def delete_old_pictures(accommodation)
    property = Property.find_by_interhome_accommodation_id(accommodation.id)
    return unless property

    accommodation.interhome_pictures.each do |picture|
      if picture.updated_at < @import_start_time
        image = Image.find_by_property_id_and_source_url(property.id, picture.url)
        if image
          if image.property.image_id == image.id
            image.property.image_id = nil
            image.property.save
          end
          image.destroy
        end
        picture.delete
      end
    end
  end

  def create_property(accommodation)
    place = InterhomePlace.find_by_country_and_region_and_place(accommodation.country, accommodation.region, accommodation.place)
    return unless place

    ipr = InterhomePlaceResort.find_by_interhome_place_code(place.code)

    property = Property.find_by_interhome_accommodation_id(accommodation.id)
    if property
      # delete the advert; we'll create a new one shortly
      property.current_advert.delete if property.current_advert
    else
      property = Property.new
    end

    property.interhome_accommodation_id = accommodation.id
    property.user_id = @interhome.id
    property.resort_id = ipr ? ipr.resort_id : @default_resort.id
    property.name = accommodation.name.blank? ? accommodation.code : accommodation.name
    property.strapline = accommodation.inside_description[0..254]
    property.address = place.name
    property.latitude = accommodation.geodata_lat
    property.longitude = accommodation.geodata_lng
    property.weekly_rent_price = accommodation.current_price
    
    return if property.weekly_rent_price.nil?
    property.currency_id = @euro.id
    property.sleeping_capacity = accommodation.pax
    property.number_of_bedrooms = accommodation.bedrooms

    if accommodation.features.include? 'parking'
      property.parking = Property::PARKING_OFF_STREET
    else
      property.parking = Property::PARKING_ON_STREET
    end

    property.pets = accommodation.features.include? 'petsallowed'
    property.smoking = !(accommodation.features.include? 'nonsmoking')
    property.tv = Property::TV_YES if accommodation.features.include? 'tv'
    property.wifi = accommodation.features.include? 'wlan'

    unless property.save
      Rails.logger.info(property.errors.to_s)
      return
    end

    accommodation.interhome_pictures.each do |picture|
      image = Image.find_by_property_id_and_source_url(property.id, picture.url)
      next if image

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

  def import_details?(d)
    return true if d.kind_of?(Hash) # Details unspecified
    'BCDFHRSV'.include?(d)
    # B: bungalow
    # C: chalet
    # D: divers
    # F: maison de champagne
    # H: village de vacances
    # R: residence
    # S: château/manoir
    # V: villa
    # Y: yacht
  end

  def xml_filename
    "interhome/#{XML_FILENAME}"
  end
end
