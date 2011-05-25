require 'spec_helper'

describe Enquiry do
  def valid_enquiry
    Enquiry.new(:name => "Alice", :email => "alice@myskichalet.co.uk",
      :phone => "01234 567890", :postcode => "AB12 3CD")
  end

  it "validates presence of name" do
    e = valid_enquiry
    e.should be_valid
    e.name = ""
    e.should_not be_valid
  end

  it "validates format of email" do
    e = valid_enquiry
    e.should be_valid
    e.email = ""
    e.should_not be_valid
    e.email = "a@b"
    e.should_not be_valid
  end

  it "validates presence of phone" do
    e = valid_enquiry
    e.should be_valid
    e.phone = ""
    e.should_not be_valid
  end

  it "validates presence of postcode" do
    e = valid_enquiry
    e.should be_valid
    e.postcode = ""
    e.should_not be_valid
  end
end
