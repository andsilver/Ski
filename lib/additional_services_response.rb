class AdditionalServicesResponse < InterhomeResponse
  attr_accessor :additional_services

  def initialize(soap_request)
    super(soap_request)

    @additional_services = []
    if additional_service_items
      additional_service_items.each do |s|
        @additional_services << AdditionalService.new(s)
      end
      @additional_services.each {|s| puts "[#{s.code}] #{s.description}"}
    end
  end

  def additional_service_items
    additional_services[0]['AdditionalServiceItem']
  end

  def additional_services
    result['AdditionalServices']
  end

  def result
    response['AdditionalServicesResult'][0]
  end

  def response
    @data['Body'][0]['AdditionalServicesResponse'][0]
  end
end
