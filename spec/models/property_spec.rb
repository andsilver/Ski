require 'spec_helper'

describe Property do
  # ActiveRecord
  it { should have_many(:images) }
  it { should have_many(:adverts) }

  # ActiveModel
  it { should validate_presence_of(:resort_id) }

  describe '.accommodation_type_description' do
    pending
  end

  describe '#accommodation_type_description' do
    pending
  end

  describe '.parking_description' do
    pending
  end

  describe '#parking_description' do
    pending
  end

  describe '.tv_description' do
    pending
  end

  describe '#tv_description' do
    pending
  end

  describe '.board_basis_description' do
    pending
  end

  describe '#board_basis_description' do
    pending
  end

  describe '.normalise_prices' do
    pending
  end

  describe '.importable_attributes' do
    pending
  end

  describe '#to_param' do
    pending
  end

  describe '#for_rent?' do
    pending
  end

  describe '#price' do
    pending
  end

  describe '#features' do
    pending
  end

  describe '#short_description' do
    pending
  end

  describe '#adjust_distances_if_needed' do
    pending
  end

  describe '#closest_distance' do
    pending
  end

  describe '#geocode' do
    pending
  end

  describe '#attempt_geocode' do
    pending
  end

  describe '#normalise_prices' do
    pending
  end

  describe '#properties_for_rent_cannot_be_new_developments' do
    pending
  end

  describe '#valid_months' do
    let(:property) { Property.new }

    it "returns a sorted array of months from Property Base Prices" do
      PropertyBasePrice.delete_all
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
