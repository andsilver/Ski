module Interhome
  class AccommodationDetailResponse < Response
    def result
      response["AccommodationDetailResult"][0]
    end

    def response
      @data["Body"][0]["AccommodationDetailResponse"][0]
    end
  end
end
