# frozen_string_literal: true

require_relative "../trip_advisor"

module TripAdvisor
  class PropertyImporter
    attr_reader :json
    attr_accessor :property, :ta_property

    def initialize(json)
      @json = json
    end

    def import
      return unless data_valid?

      import_details
      return unless ta_property.persisted?

      import_calendar
      create_base_property
      advertise
      import_images
      import_amenities
      import_reviews
    end

    def import_details
      details = PropertyDetails.new(data)
      details.import
      self.ta_property = details.property
    end

    def import_calendar
      PropertyCalendarImporter.new(ta_property, data["calendar"]).import
    end

    def create_base_property
      self.property = BaseProperty.new(ta_property).create(TripAdvisor.user)
    end

    def advertise
      return unless property
      LongTermAdvert.new(property).create
    end

    def import_images
      return unless property

      images = PropertyImages.new(property, json)
      images.import
    end

    def import_amenities
      return unless property && data["details"]["amenities"]

      property.amenities.delete_all

      data["details"]["amenities"].each do |a|
        property.amenities << Amenity.find_or_create_by(name: a)
      end
      property.save
    end

    def import_reviews
      return unless property && data["reviews"]

      property.reviews.delete_all

      data["reviews"]["reviews"].each do |r|
        review = Review.create(
          author_location: r["author_location"],
          author_name: r["author_name"],
          content: r["text"],
          property: property,
          rating: r["rating"],
          title: r["title"],
          visited_on: Date.parse("#{r["visit_date"]}-01")
        )
        property.reviews << review
      end
      property.save
    end

    private

    def data_valid?
      data
    rescue
      Rails.logger.warn(
        "Malformed JSON found in TripAdvisor::PropertyImporter"
      )
      false
    end

    def data
      @data ||= JSON.parse(json)
    end
  end
end
