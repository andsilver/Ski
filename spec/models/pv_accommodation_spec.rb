require 'rails_helper'

describe PvAccommodation do
  describe '#photo_array' do
    it 'returns an empty array if photos is blank' do
      expect(PvAccommodation.new.photo_array).to eq []
    end

    it 'returns the photos split over comma' do
      expect(PvAccommodation.new(photos: 'a.jpg,b.jpg').photo_array).to eq ['a.jpg', 'b.jpg']
    end
  end
end
