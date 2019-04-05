require "rails_helper"

describe PropertyPricer do
  it "raises ArgumentError if either :property_number or :months are omitted" do
    expect { PropertyPricer.new(invalid: true) }.to raise_error(ArgumentError)
    expect { PropertyPricer.new(months: 6) }.to raise_error(ArgumentError)
    expect { PropertyPricer.new(property_number: 20) }.to raise_error(ArgumentError)
  end

  describe "#price_in_cents" do
    fixtures :property_base_prices, :property_volume_discounts

    it "returns correct prices" do
      example_cases = [
        {months: 1, property_number: 1, cents: 1500},
        {months: 1, property_number: 2, cents: 1500}, # boundary check
        {months: 1, property_number: 3, cents: 1425}, # boundary check
        {months: 1, property_number: 4, cents: 1425}, # boundary check
        {months: 1, property_number: 11, cents: 1395},
        {months: 1, property_number: 21, cents: 1350},
        {months: 1, property_number: 31, cents: 1275},
        {months: 1, property_number: 51, cents: 1200},
        {months: 1, property_number: 101, cents: 1125},
        {months: 1, property_number: 201, cents: 1050},
        {months: 1, property_number: 301, cents: 975},

        {months: 3, property_number: 1, cents: 4000},
        {months: 3, property_number: 3, cents: 3800},
        {months: 3, property_number: 11, cents: 3720},
        {months: 3, property_number: 21, cents: 3600},
        {months: 3, property_number: 31, cents: 3400},
        {months: 3, property_number: 51, cents: 3200},
        {months: 3, property_number: 101, cents: 3000},
        {months: 3, property_number: 201, cents: 2800},
        {months: 3, property_number: 301, cents: 2600},

        {months: 6, property_number: 1, cents: 7500},
        {months: 6, property_number: 3, cents: 7125},
        {months: 6, property_number: 11, cents: 6975},
        {months: 6, property_number: 21, cents: 6750},
        {months: 6, property_number: 31, cents: 6375},
        {months: 6, property_number: 51, cents: 6000},
        {months: 6, property_number: 101, cents: 5625},
        {months: 6, property_number: 201, cents: 5250},
        {months: 6, property_number: 301, cents: 4875},

        {months: 9, property_number: 1, cents: 8000},
        {months: 9, property_number: 3, cents: 7600},
        {months: 9, property_number: 11, cents: 7440},
        {months: 9, property_number: 21, cents: 7200},
        {months: 9, property_number: 31, cents: 6800},
        {months: 9, property_number: 51, cents: 6400},
        {months: 9, property_number: 101, cents: 6000},
        {months: 9, property_number: 201, cents: 5600},
        {months: 9, property_number: 301, cents: 5200},

        {months: 12, property_number: 1, cents: 9900},
        {months: 12, property_number: 3, cents: 9405},
        {months: 12, property_number: 11, cents: 9207},
        {months: 12, property_number: 21, cents: 8910},
        {months: 12, property_number: 31, cents: 8415},
        {months: 12, property_number: 51, cents: 7920},
        {months: 12, property_number: 101, cents: 7425},
        {months: 12, property_number: 201, cents: 6930},
        {months: 12, property_number: 301, cents: 6435},
      ]
      example_cases.each do |example|
        p = PropertyPricer.new(months: example[:months],
                               property_number: example[:property_number])
        expect(p.price_in_cents).to eq(example[:cents])
      end
    end
  end
end
