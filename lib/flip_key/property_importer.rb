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
        import_pictures(property, a)
        delete_old_pictures(property)
        create_property(property, resort)
      else
        property.destroy
      end
    end

    def import_pictures(property, a)
    end

    def delete_old_pictures(property)
    end

    def create_property(fk_property, resort)
      property = prepare_property(flip_key_property_id: fk_property.id)
      property.resort = resort
      property.save
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
