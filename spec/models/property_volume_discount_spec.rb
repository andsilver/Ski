require "rails_helper"

describe PropertyVolumeDiscount do
  before do
    PropertyVolumeDiscount.create!
  end

  it { should validate_uniqueness_of(:current_property_number) }
end
