require "xmlsimple"

module Interhome
  class AccommodationImporter < ::AccommodationImporter
    XML_FILENAME = "accommodation.xml"

    def ftp_get
      FTP.get(XML_FILENAME)
    end

    # Splits the large Interhome XML file into a number of smaller files and
    # returns an array of XML filenames. Set max_files to limit the number
    # of smaller files created (for example, when testing).
    def split_xml(max_files = 0)
      xs = XMLSplitter.new(root_element: "accommodations", child_element: "accommodation", xml_filename: xml_filename, elements_per_file: 500, max_files: max_files)
      xs.split
    end

    def user_email
      "interhome@mychaletfinder.com"
    end

    def model_class
      InterhomeAccommodation
    end

    def import_accommodation(a)
      return unless import_details?(a["details"][0])

      accommodation = InterhomeAccommodation.find_by(code: a["code"][0])
      if accommodation
        # ensure the updated_at timestamp is updated
        # the save later won't touch the database if all attributes remain unchanged
        accommodation.touch
      else
        accommodation = InterhomeAccommodation.new
      end
      accommodation.code = a["code"][0].strip
      accommodation.name = a["name"][0]
      if accommodation.name.is_a?(String)
        accommodation.name.strip!
      else
        accommodation.name = ""
      end
      accommodation.country = a["country"][0].strip
      accommodation.region = a["region"][0].strip
      accommodation.place = a["place"][0].strip
      accommodation.zip = a["zip"] ? a["zip"][0].strip : "" # some countries (e.g. RoI) don't use postal codes
      accommodation.accommodation_type = a["type"][0]
      accommodation.details = a["details"][0]
      accommodation.quality = a["quality"][0]
      accommodation.brand = a["brand"][0]
      accommodation.pax = a["pax"] ? a["pax"][0] : 0
      accommodation.sqm = a["sqm"] ? a["sqm"][0] : 0
      accommodation.floor = a["floor"] ? a["floor"][0] : 0
      accommodation.rooms = a["rooms"] ? a["rooms"][0] : 0
      accommodation.bedrooms = a["bedrooms"] ? a["bedrooms"][0] : 0
      accommodation.bathrooms = a["bathrooms"] ? a["bathrooms"][0] : 0
      accommodation.toilets = a["toilets"] ? a["toilets"][0] : 0
      accommodation.features = features(a)
      if a["geodata"]
        accommodation.geodata_lat = a["geodata"][0]["lat"][0]
        accommodation.geodata_lng = a["geodata"][0]["lng"][0]
      else
        accommodation.geodata_lat = accommodation.geodata_lng = ""
      end
      accommodation.themes = themes(a)
      accommodation.permalink = accommodation.code.parameterize
      accommodation.save

      place = accommodation.interhome_place
      if place && (ipr = InterhomePlaceResort.find_by(interhome_place_code: place.code))
        import_pictures(accommodation, a)
        delete_old_pictures(accommodation)
        create_property(accommodation, ipr.resort_id, place.name)
      else
        accommodation.destroy
      end
    end

    # Imports pictures for the new or existing accommodation.
    # Touch (update timestamp of) existing pictures and add new ones.
    def import_pictures(accommodation, a)
      return unless a["pictures"]
      a["pictures"][0]["picture"].each do |p|
        url = p["url"] ? p["url"][0] : ""
        picture = InterhomePicture.find_by(interhome_accommodation_id: accommodation.id, url: url)
        if picture
          picture.touch
        else
          picture = InterhomePicture.new
          picture.picture_type = p["type"] ? p["type"][0] : ""
          picture.season = p["season"] ? p["season"][0] : ""
          picture.url = url
          accommodation.interhome_pictures << picture
        end
      end
    end

    # Delete old pictures that have been imported before but aren't mentioned
    # in the current XML file.
    def delete_old_pictures(accommodation)
      property = Property.find_by(interhome_accommodation_id: accommodation.id)
      return unless property

      accommodation.interhome_pictures.each do |picture|
        if picture.updated_at < @import_start_time
          image = Image.find_by(property_id: property.id, source_url: picture.url)
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

    def create_property(accommodation, resort_id, address)
      property = prepare_property(interhome_accommodation_id: accommodation.id)
      property.resort_id = resort_id
      property.name = accommodation.name.blank? ? accommodation.code : accommodation.name
      property.strapline = accommodation.inside_description
      property.tidy_name_and_strapline
      property.address = address
      property.latitude = accommodation.geodata_lat
      property.longitude = accommodation.geodata_lng
      property.weekly_rent_price = accommodation.current_price

      return if property.weekly_rent_price.nil?
      property.currency = gbp
      property.sleeping_capacity = accommodation.pax
      property.number_of_bedrooms = accommodation.bedrooms

      property.parking = if accommodation.features.include? "parking"
        Property::PARKING_OFF_STREET
      else
        Property::PARKING_ON_STREET
      end

      property.pets = accommodation.features.include? "petsallowed"
      property.smoking = !(accommodation.features.include? "nonsmoking")
      property.tv = Property::TV_YES if accommodation.features.include? "tv"
      property.wifi = accommodation.features.include? "wlan"

      unless property.save
        Rails.logger.info(property.errors.messages.to_s)
        accommodation.destroy
        return
      end

      accommodation.interhome_pictures.each do |picture|
        image = Image.find_by(property_id: property.id, source_url: picture.url)

        if image.nil?
          image = Image.new
          image.user_id = @user.id
          image.source_url = picture.url
          image.property_id = property.id
          image.save
        end

        if picture.picture_type == "m"
          property.image_id = image.id
          property.save
        end
      end

      # Delete orphaned images
      urls_to_keep = accommodation.interhome_pictures.map { |picture| picture.url }
      property.images.each do |image|
        unless urls_to_keep.include?(image.source_url)
          property.image = nil if property.image == image
          image.destroy
          Rails.logger.warn "Destroyed orphaned image for Interhome accommodation #{accommodation.id} - #{image.source_url}"
        end
      end

      # In case no main picture was set by Interhome
      if property.image.nil?
        property.image = property.images.first
        property.save
      end

      create_advert(property)
    end

    def gbp
      @gbp ||= Currency.find_by(code: "GBP")
    end

    def themes(a)
      return "" unless a["themes"]
      themes = []
      a["themes"][0]["theme"].each {|t| themes << t}
      themes.join(",")
    end

    def features(a)
      return "" unless a["attributes"]
      features = []
      a["attributes"][0]["attribute"].each {|f| features << f}
      features.join(",")
    end

    def import_details?(d)
      return true if d.is_a?(Hash) # Details unspecified
      "ABCDFHRSV".include?(d)
      # A: apart- hotel
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

    def accommodations(xml)
      xml["accommodation"]
    end
  end
end
