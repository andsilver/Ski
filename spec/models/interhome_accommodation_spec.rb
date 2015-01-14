require 'rails_helper'

RSpec.describe InterhomeAccommodation, type: :model do
  describe '#check_in_on_dates?' do
    it 'returns false when there is no InterhomeVacancy' do
      expect(InterhomeAccommodation.new.available_to_check_in_on_dates?([])).to be_falsey
    end

    it 'delegates to InterhomeVacancy' do
      accom = InterhomeAccommodation.new

      available = InterhomeVacancy.new
      allow(available).to receive(:available_to_check_in_on_dates?).and_return(true)
      allow(available).to receive(:[]=).and_return(nil)
      allow(available).to receive(:delete).and_return(true)
      accom.interhome_vacancy = available
      expect(accom.available_to_check_in_on_dates?([])).to be_truthy

      unavailable = InterhomeVacancy.new
      allow(unavailable).to receive(:available_to_check_in_on_dates?).and_return(false)
      allow(unavailable).to receive(:[]=).and_return(nil)
      accom.interhome_vacancy = unavailable
      expect(accom.available_to_check_in_on_dates?([])).to be_falsey
    end
  end

  describe '#feature_list' do
    it 'returns features split by comma' do
      expect(InterhomeAccommodation.new(features: 'shower,bbq').feature_list).to eq ['shower', 'bbq']
    end

    it 'returns an empty array when features is nil' do
      expect(InterhomeAccommodation.new(features: nil).feature_list).to eq []
    end
  end
end
