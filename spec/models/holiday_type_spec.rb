require 'spec_helper'

describe HolidayType do
  describe '#to_param' do
    it 'returns its slug' do
      expect(HolidayType.new(slug: 'slug').to_param).to eq 'slug'
    end
  end
end
