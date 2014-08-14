require 'rails_helper'

describe Enquiry do
  # ActiveModel
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:phone) }

  def valid_enquiry
    Enquiry.new(name: 'Alice', email: 'alice@mychaletfinder.com',
      phone: '01234 567890')
  end

  it "validates format of email" do
    e = valid_enquiry
    expect(e).to be_valid
    e.email = ""
    expect(e).not_to be_valid
    e.email = "a@b"
    expect(e).not_to be_valid
  end
end
