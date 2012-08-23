class AdditionalService
  def initialize(xml)
    @xml = xml
  end

  def code
    @xml['Code'][0]
  end

  def count
    @xml['Count'][0]
  end

  def currency
    @xml['Currency']
  end

  def description
    @xml['Description'][0]
  end

  def default_service?
    @xml['IsDefaultService'][0] == 'true'
  end

  def included?
    @xml['IsIncluded'][0] == 'true'
  end

  def insurance?
    @xml['IsInsurance'][0] == 'true'
  end

  def mandatory?
    @xml['IsMandatory'][0] == 'true'
  end

  def payment_info
    @xml['PaymentInfo'][0]
  end

  def price_rule
    @xml['PriceRule'][0]
  end

  def text
    @xml['text'][0]
  end

  def type
    @xml['Type'][0]
  end

  def valid_from
    @xml['ValidFrom'][0]
  end

  def valid_to
    @xml['ValidTo'][0]
  end
end

# XML example:

#<AdditionalServiceType>InPriceIncluded</AdditionalServiceType>
#<Amount>0</Amount>
#<Code>FC</Code>
#<Count>0</Count>
#<Currency />
#<Description>Final cleaning inclusive for stays of 6 nights and more</Description>
#<EitherOr />
#<IsDefaultService>false</IsDefaultService>
#<IsIncluded>true</IsIncluded>
#<IsInsurance>false</IsInsurance>
#<IsMandatory>true</IsMandatory>
#<PaymentInfo>Included in the price</PaymentInfo>
#<PriceRule />
#<Text />
#<Type>Y2</Type>
#<ValidFrom>2012-10-06</ValidFrom>
#<ValidTo>2012-10-13</ValidTo>
