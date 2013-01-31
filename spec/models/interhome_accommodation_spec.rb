require 'spec_helper'

describe InterhomeAccommodation do
  describe '#check_in_on_dates?' do
    it 'returns false when there is no InterhomeVacancy' do
      InterhomeAccommodation.new.available_to_check_in_on_dates?([]).should be_false
    end

    it 'delegates to InterhomeVacancy' do
      accom = InterhomeAccommodation.new

      available = mock_model(InterhomeVacancy, available_to_check_in_on_dates?: true, :[]= => nil, delete: true)
      accom.interhome_vacancy = available
      accom.available_to_check_in_on_dates?([]).should be_true

      unavailable = mock_model(InterhomeVacancy, available_to_check_in_on_dates?: false, :[]= => nil)
      accom.interhome_vacancy = unavailable
      accom.available_to_check_in_on_dates?([]).should be_false
    end
  end
end
