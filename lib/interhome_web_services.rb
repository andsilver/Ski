# Production
# Username/ ID: CH1000759
# Password: mychaletfinder
# SO: 2048

# Test
# Partner ID: CH1000723
# Pass: mychaletfinder
# Sales office to use: SO2048 in EUR

class InterhomeWebServices
  def self.test_accommodation_detail
    request('AccommodationDetail')
  end

  def self.test_additional_services
    request('AdditionalServices')
  end

  def self.test_availability
    request('Availability')
  end

  def self.test_cancellation_conditions
    request('CancellationConditions')
  end

  def self.test_price_detail
    request('PriceDetail')
  end

  def self.request(action, details = {})
    request_class = Kernel.const_get("#{action}Request")
    response_class = Kernel.const_get("#{action}Response")
    defaults = {
      url: 'https://webservices.interhome.com/quality/partnerV3/WebService.asmx',
      username: 'CH1000723',
      password: 'mychaletfinder',
      language_code: 'EN',
      currency_code: 'EUR',
      sales_office_code: '2048',
      retailer_code: 'CH1000723',

      accommodation_code: 'PT6660.50.1',
      check_in: '2012-10-01',
      check_out: '2012-10-08',
      adults: '2',
      children: '1',
      babies: '1'
    }
    opts = defaults.merge(details)
    request = request_class.new(opts)
    puts request.xml
    soap_request = SoapRequest.new(request, opts[:url])
    puts soap_request.xml_response
    response_class.new(soap_request)
  end
end
