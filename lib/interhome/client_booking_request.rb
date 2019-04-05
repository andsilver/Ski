module Interhome
  class ClientBookingRequest < Request
    def xml
      as_str = ""
      @details[:additional_services]&.each do |code, count|
        unless count == "0"
          as_str += "<AdditionalServiceInputItem><Code>#{code}</Code>" \
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
    <ClientBooking xmlns="http://www.interhome.com/webservice">
      <inputValue>
        <SalesOfficeCode>#{@details[:sales_office_code]}</SalesOfficeCode>
        <AccommodationCode>#{@details[:accommodation_code]}</AccommodationCode>
        <AdditionalServices>
        #{as_str}
        </AdditionalServices>
        <CheckIn>#{@details[:check_in]}</CheckIn>
        <CheckOut>#{@details[:check_out]}</CheckOut>
        <CustomerSalutationType>#{@details[:customer_salutation_type]}</CustomerSalutationType>
        <CustomerName>#{@details[:customer_name]}</CustomerName>
        <CustomerFirstName>#{@details[:customer_first_name]}</CustomerFirstName>
        <CustomerPhone>#{@details[:customer_phone]}</CustomerPhone>
        <CustomerFax>#{@details[:customer_fax]}</CustomerFax>
        <CustomerEmail>#{@details[:customer_email]}</CustomerEmail>
        <CustomerAddressStreet>#{@details[:customer_address_street]}</CustomerAddressStreet>
        <CustomerAddressAdditionalStreet>#{@details[:customer_address_additional_street]}</CustomerAddressAdditionalStreet>
        <CustomerAddressZIP>#{@details[:customer_address_zip]}</CustomerAddressZIP>
        <CustomerAddressPlace>#{@details[:customer_address_place]}</CustomerAddressPlace>
        <CustomerAddressState>#{@details[:customer_address_state]}</CustomerAddressState>
        <CustomerAddressCountryCode>#{@details[:customer_address_country_code]}</CustomerAddressCountryCode>
        <Comment>#{@details[:comment]}</Comment>
        <Adults>#{@details[:adults]}</Adults>
        <Babies>#{@details[:babies]}</Babies>
        <Children>#{@details[:children]}</Children>
        <LanguageCode>#{@details[:language_code]}</LanguageCode>
        <CurrencyCode>#{@details[:currency_code]}</CurrencyCode>
        <RetailerCode>#{@details[:retailer_code]}</RetailerCode>
        <RetailerExtraCode>#{@details[:retailer_extra_code]}</RetailerExtraCode>
        <PaymentType>#{@details[:payment_type]}</PaymentType>
        <CreditCardType>#{@details[:credit_card_type]}</CreditCardType>
        <CreditCardNumber>#{@details[:credit_card_number]}</CreditCardNumber>
        <CreditCardCvc>#{@details[:credit_card_cvc]}</CreditCardCvc>
        <CreditCardExpiry>#{@details[:credit_card_expiry]}</CreditCardExpiry>
        <CreditCardHolder>#{@details[:credit_card_holder]}</CreditCardHolder>
        <BankAccountNumber>#{@details[:bank_account_number]}</BankAccountNumber>
        <BankCode>#{@details[:bank_code]}</BankCode>
        <BankAccountHolder>#{@details[:bank_account_holder]}</BankAccountHolder>
      </inputValue>
    </ClientBooking>
  </soap:Body>
</soap:Envelope>)
    end

    def action
      "ClientBooking"
    end
  end
end
