module Interhome
  class AdditionalService
    def initialize(xml)
      @xml = xml
    end

    def amount
      @xml["Amount"][0]
    end

    def amount_or_free
      amount == "0" ? "Free" : amount
    end

    def code
      @xml["Code"][0]
    end

    def count
      @xml["Count"][0].to_i
    end

    def currency
      @xml["Currency"][0].is_a?(Hash) ? "" : @xml["Currency"][0]
    end

    def description
      @xml["Description"][0]
    end

    def default_service?
      @xml["IsDefaultService"][0] == "true"
    end

    def included?
      @xml["IsIncluded"][0] == "true"
    end

    def insurance?
      @xml["IsInsurance"][0] == "true"
    end

    def mandatory?
      @xml["IsMandatory"][0] == "true"
    end

    def payment_info
      @xml["PaymentInfo"][0]
    end

    def price_rule
      @xml["PriceRule"][0]
    end

    def price_rule_desc
      return "" if price_rule.empty?
      {
        "PD" => "Per person per day",
        "PW" => "Per person per week",
        "UD" => "Per unit (object) per day",
        "UW" => "Per unit (object) per week",
        "P1" => "Payable once per person",
        "U1" => "Payable once",
        "UH" => "Per hour",
        "K1" => "Per kilowatt hour",
        "M1" => "Per m3",
        "X1" => "According to use",
        "NO" => "No calculation relevance",
        "LX" => "Per litre",
      }[price_rule]
    end

    def text
      @xml["Text"][0].is_a?(Hash) ? "" : @xml["Text"][0]
    end

    def n_type?
      type[0] == "N"
    end

    def type
      @xml["Type"][0]
    end

    def type_desc
      return "" if type.empty?
      {
        "N1" => "Bookable (additional cost)",
        "N2" => "Bookable (included in price)",
        "N4" => "Bookable and payable in resort",
        "Y1" => "Mandatory fee on invoice",
        "Y2" => "Included in the price",
        "Y4" => "Mandatory fee payable in resort",
        "Y5" => "Added to invoice, payable in resort",
        "Y6" => "Own arrangement",
      }[type]
    end

    def valid_from
      @xml["ValidFrom"][0]
    end

    def valid_to
      @xml["ValidTo"][0]
    end
  end
end

# XML example:

# <AdditionalServiceType>InPriceIncluded</AdditionalServiceType>
# <Amount>0</Amount>
# <Code>FC</Code>
# <Count>0</Count>
# <Currency />
# <Description>Final cleaning inclusive for stays of 6 nights and more</Description>
# <EitherOr />
# <IsDefaultService>false</IsDefaultService>
# <IsIncluded>true</IsIncluded>
# <IsInsurance>false</IsInsurance>
# <IsMandatory>true</IsMandatory>
# <PaymentInfo>Included in the price</PaymentInfo>
# <PriceRule />
# <Text />
# <Type>Y2</Type>
# <ValidFrom>2012-10-06</ValidFrom>
# <ValidTo>2012-10-13</ValidTo>
