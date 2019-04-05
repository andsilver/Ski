require "rails_helper"

describe Coupon do
  before do
    Coupon.create!(code: "TEST", number_of_adverts: 1)
  end

  # ActiveRecord
  it { should have_many(:users) }
  it { should have_many(:order_lines) }

  # ActiveModel
  it { should validate_presence_of(:code) }
  it { should validate_uniqueness_of(:code) }
  it { should validate_inclusion_of(:number_of_adverts).in_range(1..1000000).with_message("is not in the range 1-1000000") }

  describe "#expired?" do
    pending
  end
end
