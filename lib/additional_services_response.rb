class AdditionalServicesResponse < InterhomeResponse
  attr_accessor :additional_services

  def initialize(soap_request)
    super(soap_request)

    @additional_services = []
    if additional_service_items
      additional_service_items.each do |s|
        @additional_services << AdditionalService.new(s)
      end
      @additional_services.each {|s| puts "[#{s.code} - #{s.type}] #{s.description} #{s.amount} #{s.currency} #{s.price_rule_desc}"}
    end
  end

  def bookable
    @additional_services.select { |s| s.type == 'N1' }
  end

  def included
    @additional_services.select { |s| s.type == 'Y2' }
  end

  def not_included
    @additional_services.select { |s| s.type == 'Y4' }
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
