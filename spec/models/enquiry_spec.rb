require 'spec_helper'

describe Enquiry do
  # ActiveModel
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:phone) }

  def valid_enquiry
    Enquiry.new(:name => "Alice", :email => "alice@mychaletfinder.com",
      :phone => "01234 567890")
  end

  it "validates format of email" do
    e = valid_enquiry
    e.should be_valid
    e.email = ""
    e.should_not be_valid
    e.email = "a@b"
    e.should_not be_valid
  end
end
