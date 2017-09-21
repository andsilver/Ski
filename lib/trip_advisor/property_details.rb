# frozen_string_literal: true

module TripAdvisor
  # Imports a single TripAdvisor property from a JSON-encoded string.
  class PropertyDetails
    attr_reader :json

    def initialize(json)
      @json = json
    end

    def import
      copy_details(
        :bathrooms, :bedrooms, :beds, :booking_option, :can_accept_inquiry,
        :city, :country,
        :country_code, :lat_long, :min_stay_high, :min_stay_low,
        :postal_code, :review_average, :search_url,
        :show_pin, :sleeps, :status, :trip_advisor_location_id, :url
      )
      property.save
    end

    def property
      @property ||= TripAdvisorProperty.find_or_initialize_by(id: data['id'])
    end

    private

    def copy_details(*attributes)
      attributes.each { |a| property.send("#{a}=", send(a)) }
    end

    def data
      @data ||= JSON.parse(json)
    end

    def details
      data['details']
    end

    def bedrooms
      details['bedrooms']
    end

    def beds
      details['beds']
    end

    def sleeps
      details['sleeps']
    end

    def bathrooms
      details['bathrooms']
    end

    def country
      details['country']
    end

    def city
      details['city']
    end

    def url
      details['url']
    end

    def status
      details['status']
    end

    def review_average
      details['review_average']
    end

    def show_pin
      details['show_pin']
    end

    def lat_long
      details['lat_long']
    end

    def country_code
      details['country_code']
    end

    def trip_advisor_location_id
      details['ta_geo_location_id']
    end

    def postal_code
      details['postal_code']
    end

    def search_url
      # TripAdvisor has a typo
      details['seach_url']
    end

    def can_accept_inquiry
      details['can_accept_inquiry']
    end

    def booking_option
      details['booking_option']
    end

    def min_stay_high
      details['min_stay_high']
    end

    def min_stay_low
      details['min_stay_low']
    end
  end
end
