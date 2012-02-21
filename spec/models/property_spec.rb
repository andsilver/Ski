require 'spec_helper'

describe Property do

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
