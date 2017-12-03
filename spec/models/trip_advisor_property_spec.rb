# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TripAdvisorProperty, type: :model do
  describe 'associations' do
    it { should have_one(:property).dependent(:destroy) }
    it { should belong_to :trip_advisor_location }
    it { should delegate_method(:resort).to(:trip_advisor_location) }
    it { should belong_to(:currency) }
    it do
      should have_many(:trip_advisor_calendar_entries).dependent(:delete_all)
    end
  end

  describe 'validations' do
    it do
      should validate_numericality_of(:review_average)
        .is_less_than_or_equal_to(5)
    end
    it { should validate_presence_of :currency }
    it { should validate_presence_of :starting_price }
  end

  describe '#cache_availability' do
    it 'accepts an array of dates' do
      prop = TripAdvisorProperty.new
      prop.cache_availability([Date.current])
    end

    it 'creates an AVAILABLE entry for each date with no booked calendar' do
      prop = FactoryBot.create(:property)
      ta_prop = FactoryBot.create(:trip_advisor_property, property: prop)
      dates = [Date.new(2017, 12, 2), Date.new(2017, 12, 3)]
      ta_prop.cache_availability(dates)
      availabilities = prop.availabilities.order(:start_date)
      expect(availabilities.count).to eq 2
      expect(availabilities.first.start_date).to eq dates[0]
      expect(availabilities.last.start_date).to eq dates[1]
      availabilities.each do |a|
        expect(a.availability).to eq Availability::AVAILABLE
      end
    end

    it 'creates an UNAVAILABLE availability for each booked date' do
      prop = FactoryBot.create(:property)
      ta_prop = FactoryBot.create(:trip_advisor_property, property: prop)
      FactoryBot.create(
        :trip_advisor_calendar_entry,
        trip_advisor_property: ta_prop,
        status: 'BOOKED',
        inclusive_start: Date.new(2017, 12, 3),
        exclusive_end: Date.new(2017, 12, 5)
      )
      dates = [
        Date.new(2017, 12, 2), Date.new(2017, 12, 3),
        Date.new(2017, 12, 4), Date.new(2017, 12, 5)
      ]
      ta_prop.cache_availability(dates)
      availabilities = prop.availabilities.order(:start_date).to_a
      expect(availabilities.count).to eq 4

      expect(availabilities[0].start_date).to eq dates[0]
      expect(availabilities[0].availability).to eq Availability::AVAILABLE

      expect(availabilities[1].start_date).to eq dates[1]
      expect(availabilities[1].availability).to eq Availability::UNAVAILABLE

      expect(availabilities[2].start_date).to eq dates[2]
      expect(availabilities[2].availability).to eq Availability::UNAVAILABLE

      expect(availabilities[3].start_date).to eq dates[3]
      expect(availabilities[3].availability).to eq Availability::AVAILABLE
    end
  end
end
