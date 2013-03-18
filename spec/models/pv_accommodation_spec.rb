require 'spec_helper'

describe PvAccommodation do
  describe '#photo_array' do
    it 'returns an empty array if photos is blank' do
      PvAccommodation.new.photo_array.should == []
    end

    it 'returns the photos split over comma' do
      PvAccommodation.new(photos: 'a.jpg,b.jpg').photo_array.should == ['a.jpg', 'b.jpg']
    end
  end
end
