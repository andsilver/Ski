module Interhome
  class ClientBookingResponse < Response
    def booking_id
      result["BookingID"][0]
    end

    def result
      response["ClientBookingResult"][0]
    end

    def response
      @data["Body"][0]["ClientBookingResponse"][0]
    end
  end
end
