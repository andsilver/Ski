# frozen_string_literal: true

module TripAdvisor
  # Imports images for a single TripAdvisor property from a JSON-encoded string.
  class PropertyImages
    attr_reader :json, :property

    def initialize(property, json)
      @property = property
      @json = json
    end

    def import
      photo_urls.each { |pu| import_photo(pu["jumbo_url"]) }
      delete_old_photos
      set_main_photo
    end

    private

    def photo_urls
      data["photo_urls"] || []
    end

    def data
      @data ||= JSON.parse(json)
    end

    def import_photo(photo_url)
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

    def delete_old_photos
      property.images.where("updated_at < ?", Time.current - 1.day).destroy_all
    end

    def set_main_photo
      if property.reload.image.nil?
        property.image = property.images.first
        property.save
      end
    end
  end
end
