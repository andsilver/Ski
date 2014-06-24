require 'rails_helper'

describe InterhomeAccommodation do
  describe '#check_in_on_dates?' do
    it 'returns false when there is no InterhomeVacancy' do
      expect(InterhomeAccommodation.new.available_to_check_in_on_dates?([])).to be_falsey
    end

    it 'delegates to InterhomeVacancy' do
      accom = InterhomeAccommodation.new

      available = InterhomeVacancy.new
      available.stub(available_to_check_in_on_dates?: true)
      available.stub(:[]= => nil)
      available.stub(delete: true)
      accom.interhome_vacancy = available
      expect(accom.available_to_check_in_on_dates?([])).to be_truthy

      unavailable = InterhomeVacancy.new
      unavailable.stub(available_to_check_in_on_dates?: false)
      unavailable.stub(:[]= => nil)
      accom.interhome_vacancy = unavailable
      expect(accom.available_to_check_in_on_dates?([])).to be_falsey
    end
  end
end
