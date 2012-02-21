require 'spec_helper'

describe Property do

  describe '#valid_months' do
    let(:property) { Property.new }

    it "returns a sorted array of months from Property Base Prices" do
      PropertyBasePrice.create!([
        {:number_of_months => 3,  :price => 55},
        {:number_of_months => 12, :price => 149},
        {:number_of_months => 6,  :price => 89}
      ])
      property.valid_months.should == [3, 6, 12]
    end
  end

  describe '#default_months' do
    let(:property) { Property.new }

    context "when property is for sale" do
      it "returns 3" do
        property.for_sale = true
        property.default_months.should == 3
      end
    end

    context "when property is for rent" do
      it "returns 12" do
        property.for_sale = false
        property.default_months.should == 12
      end
    end
  end
end
