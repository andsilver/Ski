module Interhome
  class PricesRequest < Request
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
    <Prices xmlns="http://www.interhome.com/webservice">
      <inputValue>
        <SalesOfficeCode>#{@details[:sales_office_code]}</SalesOfficeCode>
        <CurrencyCode>#{@details[:currency_code]}</CurrencyCode>
        <LanguageCode>#{@details[:language_code]}</LanguageCode>
        <Stays>
          <StayItem>
            <AccommodationCode>#{@details[:accommodation_code]}</AccommodationCode>
            <CheckIn>#{@details[:check_in]}</CheckIn>
            <CheckOut>#{@details[:check_out]}</CheckOut>
          </StayItem>
        </Stays>
      </inputValue>
    </Prices>
  </soap:Body>
</soap:Envelope>)
    end

    def action
      'Availability'
    end
  end
end
