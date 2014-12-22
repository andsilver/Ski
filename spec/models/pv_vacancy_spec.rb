require 'rails_helper'

describe PvVacancy do
  describe '.delete_old' do
    it 'deletes vacancies that have start_date before today' do
      stale = FactoryGirl.create(:pv_vacancy, start_date: Date.today - 1.day)
      fresh = FactoryGirl.create(:pv_vacancy, start_date: Date.today + 1.day)
      PvVacancy.delete_old
      expect(PvVacancy.count).to eq 1
      expect(PvVacancy.first).to eq fresh
    end
  end
end
