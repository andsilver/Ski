module Interhome
  class AccommodationDetailRequest < Request
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
    <AccommodationDetail xmlns="http://www.interhome.com/webservice">
      <inputValue>
        <AccommodationCode>#{@details[:accommodation_code]}</AccommodationCode>
        <LanguageCode>#{@details[:language_code]}</LanguageCode>
      </inputValue>
    </AccommodationDetail>
  </soap:Body>
</soap:Envelope>)
    end

    def action
      "AccommodationDetail"
    end
  end
end
