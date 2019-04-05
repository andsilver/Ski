module Interhome
  class AdditionalServicesRequest < Request
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
    <AdditionalServices xmlns="http://www.interhome.com/webservice">
      <inputValue>
        <AccommodationCode>#{@details[:accommodation_code]}</AccommodationCode>
        <LanguageCode>#{@details[:language_code]}</LanguageCode>
        <CurrencyCode>#{@details[:currency_code]}</CurrencyCode>
        <SalesOfficeCode>#{@details[:sales_office_code]}</SalesOfficeCode>
        <CheckIn>#{@details[:check_in]}</CheckIn>
        <CheckOut>#{@details[:check_out]}</CheckOut>
        <RetailerCode>#{@details[:retailer_code]}</RetailerCode>
        <Adults>#{@details[:adults]}</Adults>
        <Children>#{@details[:children]}</Children>
        <Babies>#{@details[:babies]}</Babies>
      </inputValue>
    </AdditionalServices>
  </soap:Body>
</soap:Envelope>)
    end

    def action
      "AdditionalServices"
    end
  end
end
