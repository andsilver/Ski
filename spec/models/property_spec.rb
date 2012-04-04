require 'spec_helper'

describe Property do
  # ActiveRecord
  it { should have_many(:images) }
  it { should have_many(:adverts) }

  # ActiveModel
  it { should ensure_length_of(:name).is_at_least(4).is_at_most(50) }
  it { should validate_presence_of(:resort_id) }
  it { should ensure_inclusion_of(:star_rating).in_range(1..5).with_message("is not in the range 1-5") }

  it { should respond_to(:star_rating) }

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
    it 'returns true when listing_type is LISTING_TYPE_FOR_RENT' do
      property = Property.new(:listing_type => Property::LISTING_TYPE_FOR_RENT)
      property.for_rent?.should be_true
    end

    it 'returns false when listing_type is anything else' do
      property = Property.new(:listing_type => Property::LISTING_TYPE_FOR_SALE)
      property.for_rent?.should be_false
      property = Property.new(:listing_type => Property::LISTING_TYPE_HOTEL)
      property.for_rent?.should be_false
    end
  end

  describe '#for_sale?' do
    it 'returns true when listing_type is LISTING_TYPE_FOR_SALE' do
      property = Property.new(:listing_type => Property::LISTING_TYPE_FOR_SALE)
      property.for_sale?.should be_true
    end
  end

  describe '#hotel?' do
    it 'returns true when listing_type is LISTING_TYPE_HOTEL' do
      property = Property.new(:listing_type => Property::LISTING_TYPE_HOTEL)
      property.hotel?.should be_true
    end
  end

  describe '#price' do
    pending
  end

  describe '#features' do
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
        property.listing_type = Property::LISTING_TYPE_FOR_SALE
        property.default_months.should == 3
      end
    end

    context "when property is for rent" do
      it "returns 12" do
        property.listing_type = Property::LISTING_TYPE_FOR_RENT
        property.default_months.should == 12
      end
    end
  end

  describe "#tidy_name_and_strapline" do
    let(:property) { Property.new }

    context "when the strapline is blank" do
      context "when the description is blank" do
        it "leaves the strapline blank" do
          property.tidy_name_and_strapline
          property.strapline.should eq('')
        end
      end

      context "when the description is not blank" do
        it "leaves sets the strapline to the first 255 chars of description" do
          property.description = 'x' * 256
          property.tidy_name_and_strapline
          property.strapline.should eq('x' * 255)
        end
      end
    end

    context "when the strapline is not blank" do
      it "truncates strapline to 255 chars" do
        property.strapline = 'x' * 256
        property.tidy_name_and_strapline
        property.strapline.should eq('x' * 255)
      end
    end

    it "truncates name to 50 chars" do
      property.name = 'x' * 51
      property.tidy_name_and_strapline
      property.name.should eq('x' * 50)
    end
  end
end
