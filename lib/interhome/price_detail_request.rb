module Interhome
  class PriceDetailRequest
    def initialize(details)
      @details = details
    end

    def xml
      as_str = ""
      @details[:additional_services]&.each do |code, count|
        unless count == "0"
          as_str += "<AdditionalServiceInputItem><Code>#{code}</Code>" +
            "<Count>#{count}</Count></AdditionalServiceInputItem>"
        end
      end
      %(<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <ServiceAuthHeader xmlns="http://www.interhome.com/webservice">
      <Username>#{@details[:username]}</Username>
      <Password>#{@details[:password]}</Password>
    </ServiceAuthHeader>
  </soap:Header>
  <soap:Body>
    <PriceDetail xmlns="http://www.interhome.com/webservice">
      <inputValue>
        <AccommodationCode>#{@details[:accommodation_code]}</AccommodationCode>
        <AdditionalServices>
        #{as_str}
        </AdditionalServices>
        <CheckIn>#{@details[:check_in]}</CheckIn>
        <CheckOut>#{@details[:check_out]}</CheckOut>
        <SalesOfficeCode>#{@details[:sales_office_code]}</SalesOfficeCode>
        <CurrencyCode>#{@details[:currency_code]}</CurrencyCode>
        <LanguageCode>#{@details[:language_code]}</LanguageCode>
        <RetailerCode>#{@details[:retailer_code]}</RetailerCode>
        <Adults>#{@details[:adults]}</Adults>
        <Children>#{@details[:children]}</Children>
        <Babies>#{@details[:babies]}</Babies>
      </inputValue>
    </PriceDetail>
  </soap:Body>
</soap:Envelope>)
    end

    def action
      "PriceDetail"
    end
  end
end
