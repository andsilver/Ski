class PriceDetailResponse < InterhomeResponse
  attr_accessor :additional_services

  include AdditionalServicesMixin

  def initialize(soap_request)
    super(soap_request)

    initialize_additional_services
  end

  def price
    result['Price'][0]
  end

  def total
    result['Total'][0]
  end

  def result
    response['PriceDetailResult'][0]
  end

  def response
    @data['Body'][0]['PriceDetailResponse'][0]
  end
end
