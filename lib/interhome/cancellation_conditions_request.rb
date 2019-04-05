module Interhome
  class CancellationConditionsRequest
    def initialize(details)
      @details = details
    end

    def xml
      %(<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <ServiceAuthHeader xmlns="http://www.interhome.com/webservice">
      <Username>#{@details[:username]}</Username>
      <Password>#{@details[:password]}</Password>
    </ServiceAuthHeader>
  </soap:Header>
  <soap:Body>
    <CancellationConditions xmlns="http://www.interhome.com/webservice">
      <inputValue>
        <SalesOfficeCode>#{@details[:sales_office_code]}</SalesOfficeCode>
      </inputValue>
    </CancellationConditions>
  </soap:Body>
</soap:Envelope>)
    end

    def action
      "CancellationConditions"
    end
  end
end
