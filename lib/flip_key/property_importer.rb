module FlipKey
  class PropertyImporter < ::AccommodationImporter
    def model_class
      FlipKeyProperty
    end

    def user_email
      'flipkey@mychaletfinder.com'
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
        create_property(property, resort, a)
      else
        property.destroy
      end
    end

    def import_pictures(property, xml)
      xml['property_photos'][0]['property_photo'].each do |photo|
        prefix = 'large'
        photo_url = 'http://images1.flipkey.com/img/photos/' + photo['base_url'][0] + '/' + prefix + '_' + photo['photo_file_name'][0]
        image = Image.find_by(property_id: property.id, source_url: photo_url)
        if image
          image.touch
        elsif photo['base_url']
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

    def create_property(fk_property, resort, xml)
      property = prepare_property(flip_key_property_id: fk_property.id)
      property.resort = resort
      property.currency = @euro
      property.name = xml['property_details'][0]['name'][0].strip
      property.address = "Somewhere on Earth"
      property.save
      import_pictures(property, xml)
      create_advert(property)
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
  end
end
