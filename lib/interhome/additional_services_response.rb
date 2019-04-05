module Interhome
  class AdditionalServicesResponse < Response
    attr_accessor :additional_services

    include AdditionalServicesMixin

    def initialize(soap_request)
      super(soap_request)

      initialize_additional_services
    end

    def result
      response["AdditionalServicesResult"][0]
    end

    def response
      @data["Body"][0]["AdditionalServicesResponse"][0]
    end
  end
end
