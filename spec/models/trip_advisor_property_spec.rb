# frozen_string_literal: true

require "rails_helper"

RSpec.describe TripAdvisorProperty, type: :model do
  describe "associations" do
    it { should have_one(:property).dependent(:destroy) }
    it { should belong_to :trip_advisor_location }
    it { should delegate_method(:resort).to(:trip_advisor_location) }
    it { should belong_to(:currency) }
    it do
      should have_many(:trip_advisor_calendar_entries).dependent(:delete_all)
    end
  end

  describe "validations" do
    it do
      should validate_numericality_of(:review_average)
        .is_less_than_or_equal_to(5)
    end
    it { should validate_presence_of :currency }
    it { should validate_numericality_of :min_stay_high }
    it { should validate_numericality_of :min_stay_low }
    it { should validate_numericality_of :sleeps }
    it { should validate_presence_of :starting_price }
  end

  describe "#cache_availability" do
    it "accepts an array of dates" do
      prop = FactoryBot.build_stubbed(:property)
      ta_prop = TripAdvisorProperty.new(property: prop)
      ta_prop.cache_availability([Date.current])
    end

    it "creates an AVAILABLE entry for each date with no booked calendar" do
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

    it "creates an UNAVAILABLE availability for each booked date" do
      prop = FactoryBot.create(:property)
      ta_prop = FactoryBot.create(:trip_advisor_property, property: prop)
      FactoryBot.create(
        :trip_advisor_calendar_entry,
        trip_advisor_property: ta_prop,
        status: "BOOKED",
        inclusive_start: Date.new(2017, 12, 3),
        exclusive_end: Date.new(2017, 12, 5)
      )
      dates = [
        Date.new(2017, 12, 2), Date.new(2017, 12, 3),
        Date.new(2017, 12, 4), Date.new(2017, 12, 5),
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

  describe "#clear_calendar" do
    it "deletes all TripAdvisorCalendarEntries" do
      ta_prop = FactoryBot.create(:trip_advisor_property)
      FactoryBot.create(
        :trip_advisor_calendar_entry, trip_advisor_property: ta_prop
      )
      ta_prop.clear_calendar
      expect(ta_prop.trip_advisor_calendar_entries.count).to eq 0
    end
  end

  describe "#booked_on?" do
    it "returns falsey for any date when there are no bookings" do
      expect(TripAdvisorProperty.new.booked_on?(Date.current)).to be_falsey
    end

    it "returns falsey when the date is not one which is booked" do
      prop = FactoryBot.create(:trip_advisor_property)
      TripAdvisorCalendarEntry.create!(
        trip_advisor_property: prop,
        inclusive_start: Date.current + 1.day,
        exclusive_end: Date.current + 2.days,
        status: TripAdvisorCalendarEntry::BOOKED
      )
      expect(prop.booked_on?(Date.current)).to be_falsey
      expect(prop.booked_on?(Date.current + 2.days)).to be_falsey
    end

    it "returns truthy when the date is one which is booked" do
      prop = FactoryBot.create(:trip_advisor_property)
      TripAdvisorCalendarEntry.create!(
        trip_advisor_property: prop,
        inclusive_start: Date.current + 1.day,
        exclusive_end: Date.current + 2.days,
        status: TripAdvisorCalendarEntry::BOOKED
      )
      expect(prop.booked_on?(Date.current + 1.day)).to be_truthy
    end
  end

  describe "#check_in_dates" do
    it "returns up to a [leap] year of dates" do
      expect(TripAdvisorProperty.new.check_in_dates.length).to eq 366
    end

    it "does not include dates which are booked on" do
      prop = FactoryBot.create(:trip_advisor_property)
      TripAdvisorCalendarEntry.create!(
        trip_advisor_property: prop,
        inclusive_start: Date.current + 1.day,
        exclusive_end: Date.current + 2.days,
        status: TripAdvisorCalendarEntry::BOOKED
      )
      dates = prop.check_in_dates
      expect(dates.first).to eq Date.current
      expect(dates.second).to eq Date.current + 2.days
      expect(dates).not_to include Date.current + 1.day
    end
  end

  describe "#check_out_dates" do
    it "returns first date after min_stay_low days" do
      prop = TripAdvisorProperty.new(min_stay_low: 4)
      expect(prop.check_out_dates(Date.current).first)
        .to eq (Date.current + 4.days)
    end

    it "returns up to 30 days (with a min_stay_low of 1)" do
      prop = TripAdvisorProperty.new(min_stay_low: 1)
      expect(prop.check_out_dates(Date.current).length).to eq 30
    end

    it "stops returning dates when interrupted by a booking, though includes " \
    "first date of booking as latest check out" do
      prop = FactoryBot.create(:trip_advisor_property, min_stay_low: 1)
      TripAdvisorCalendarEntry.create!(
        trip_advisor_property: prop,
        inclusive_start: Date.current + 2.day,
        exclusive_end: Date.current + 4.days,
        status: TripAdvisorCalendarEntry::BOOKED
      )
      dates = prop.check_out_dates(Date.current)
      expect(dates.length).to eq 2
      expect(dates.first).to eq Date.current + 1.day
      expect(dates.second).to eq Date.current + 2.days
    end
  end
end
