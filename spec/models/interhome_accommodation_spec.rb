require 'spec_helper'

describe InterhomeAccommodation do
  describe '#check_in_on_dates?' do
    it 'returns false when there is no InterhomeVacancy' do
      expect(InterhomeAccommodation.new.available_to_check_in_on_dates?([])).to be_false
    end

    it 'delegates to InterhomeVacancy' do
      accom = InterhomeAccommodation.new

      available = mock_model(InterhomeVacancy, available_to_check_in_on_dates?: true, :[]= => nil, delete: true).as_null_object
      accom.interhome_vacancy = available
      expect(accom.available_to_check_in_on_dates?([])).to be_true

      unavailable = mock_model(InterhomeVacancy, available_to_check_in_on_dates?: false, :[]= => nil).as_null_object
      accom.interhome_vacancy = unavailable
      expect(accom.available_to_check_in_on_dates?([])).to be_false
    end
  end
end
