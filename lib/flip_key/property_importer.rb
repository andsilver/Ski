module FlipKey
  class PropertyImporter < ::AccommodationImporter
    def model_class
      FlipKeyProperty
    end

    def user_email
      FlipKey::user_email
    end

    def import_accommodation(a)
      property = FlipKeyProperty.find_by(url: url(a))
      if property
        # ensure the updated_at timestamp is updated
        # the save later won't touch the database if all attributes remain unchanged
        property.touch
      else
        property = FlipKeyProperty.new
      end
      property.url = url(a)
      property.json_data = a.to_json
      property.save

      location = FlipKeyLocation.find_by(id: location_id(a))
      if resort = location.try(:resort)
        begin
          create_property(property, resort, a)
        rescue
          Rails.logger.warn "Could not create property for FlipKey property #{property.url}"
          property.destroy
        end
      else
        property.destroy
      end
    end

    def import_pictures(property, xml)
      xml['property_photos'][0]['property_photo'].each do |photo|
        if photo['largest_image_prefix']
          prefix = photo['largest_image_prefix'][0]
          photo_url = 'http://images1.flipkey.com/img/photos/' + photo['base_url'][0] + '/' + prefix + '_' + photo['photo_file_name'][0]
        else
          photo_url = photo['ta_image'][0]
        end
        image = Image.find_by(property_id: property.id, source_url: photo_url)
        if image
          image.touch
        else
          image = Image.new(property_id: property.id)
          image.source_url = photo_url
          if image.save && property.image.nil?
            property.image = image
            property.save
          end
        end
      end
      property.images.where('updated_at < ?', @import_start_time).destroy_all
      if property.reload.image.nil?
        property.image = property.images.first
        property.save
      end
    end

    # Creates a +Property+ for the +FlipKeyProperty+ +fk_property+, imports
    # pictures and creates an +Advert+.
    #
    # +ActiveRecord::RecordInvalid+ gets raised if the +Property+ cannot be
    # saved.
    def create_property(fk_property, resort, xml)
      property = prepare_property(flip_key_property_id: fk_property.id)
      property.perform_geocode = false
      property.resort = resort
      property.currency = @euro
      property.name = xml['property_details'][0]['name'][0].strip
      property.strapline = xml['property_descriptions'][0]['property_description'][0]['description'][0].strip
      property.tidy_name_and_strapline
      property.address = "Somewhere on Earth"
      property.sleeping_capacity = xml['property_details'][0]['occupancy'][0].strip
      property.accommodation_type = accommodation_type(xml)
      begin
        property.weekly_rent_price = weekly_rent_price(xml)
      rescue
        Rails.logger.warn "Could not get weekly rent price for FlipKey property #{fk_property.url}"
        raise
      end
      property.save!
      import_pictures(property, xml)
      create_advert(property)
    end

    # Returns one of <tt>Property::ACCOMMODATION_TYPES</tt> based on the
    # FlipKey +property_type+ value.
    def accommodation_type(xml)
      case xml['property_details'][0]['property_type'][0]
      when 'Apt. / Condo'
        Property::ACCOMMODATION_TYPE_APARTMENT
      when 'House'
        Property::ACCOMMODATION_TYPE_HOUSE
      when 'Villa'
        Property::ACCOMMODATION_TYPE_VILLA
      else
        Property::ACCOMMODATION_TYPE_CHALET
      end
    end

    def accommodations(xml)
      xml['property']
    end

    def url(property_xml)
      property_xml['property_details'][0]['url'][0].strip
    end

    def location_id(property_xml)
      property_xml['property_addresses'][0]['new_location_id'][0]
    end

    # Gets the weekly rent price from week_min_rate if present or seven times
    # the day_min_rate otherwise.
    #
    # Raises if neither of these are present.
    def weekly_rent_price(property_xml)
      begin
        if property_xml['property_rate_summary'][0]['week_min_rate'][0].kind_of?(Hash)
          7 * property_xml['property_rate_summary'][0]['day_min_rate'][0].strip.to_i
        else
          property_xml['property_rate_summary'][0]['week_min_rate'][0].strip
        end
      rescue
        raise 'week_min_rate and day_min_rate absent'
      end
    end
  end
end
