require 'spec_helper'

describe InterhomeVacancy do
  let(:vacancy) { InterhomeVacancy.new(startday: Date.new(2012, 10, 10)) }

  describe '#minstay_on' do
    before do
      # 0 - not bookable
      # A - 1 day
      # B - 2 days ...
      # N - 14 days
      # Z - 26 days
      vacancy.minstay = '0ANZ'
    end

    it 'returns 0 when not bookable' do
      vacancy.minstay_on(Date.new(2012, 10, 10)).should == 0
    end

    it 'returns 1 for A' do
      vacancy.minstay_on(Date.new(2012, 10, 11)).should == 1
    end

    it 'returns 14 for N' do
      vacancy.minstay_on(Date.new(2012, 10, 12)).should == 14
    end

    it 'returns 26 for Z' do
      vacancy.minstay_on(Date.new(2012, 10, 13)).should == 26
    end

    it 'returns nil for other dates' do
      vacancy.minstay_on(Date.new(2012, 10, 9)).should be_nil
      vacancy.minstay_on(Date.new(2012, 10, 14)).should be_nil
    end
  end

  describe '#check_in_on?' do
    before do
      # C - check-in and check-out
      # I - check-in only
      # X - no action possible
      # O - check-out only
      vacancy.changeover = 'CIXO'
    end

    it 'returns true when the check in value is C or I' do
      vacancy.check_in_on?(Date.new(2012, 10, 10)).should be_true
      vacancy.check_in_on?(Date.new(2012, 10, 11)).should be_true
    end

    it 'returns false when the check in value is X or O' do
      vacancy.check_in_on?(Date.new(2012, 10, 12)).should be_false
      vacancy.check_in_on?(Date.new(2012, 10, 13)).should be_false
    end
  end

  describe '#available_to_check_in_on_dates?' do
    before do
      vacancy.availability = 'NNYYYY'
      vacancy.changeover = 'CXCICO'
    end

    it 'returns false if availability is not Y' do
      vacancy.availability = 'NN'
      vacancy.changeover = 'CX'
      vacancy.available_to_check_in_on_dates?([Date.new(2012, 10, 10), Date.new(2012, 10, 11)]).should be_false
    end

    it 'returns true if all dates can be checked in on and are available' do
      vacancy.availability = 'YY'
      vacancy.changeover = 'CI'
      vacancy.available_to_check_in_on_dates?([Date.new(2012, 10, 10), Date.new(2012, 10, 11)]).should be_true
    end

    it 'returns false if any date cannot be checked in on' do
      vacancy.availability = 'YY'
      vacancy.changeover = 'CO'
      vacancy.available_to_check_in_on_dates?([Date.new(2012, 10, 10), Date.new(2012, 10, 11)]).should be_false

      vacancy.availability = 'NY'
      vacancy.changeover = 'CC'
      vacancy.available_to_check_in_on_dates?([Date.new(2012, 10, 10), Date.new(2012, 10, 11)]).should be_false
    end
  end

  describe '#get_value_for_date' do
    it 'returns "unknown" for dates in the past' do
      vacancy.get_value_for_date('ABC', Date.new(2012, 10, 9)).should == 'unknown'
    end

    it 'returns "unknown" for dates too far in the future' do
      vacancy.get_value_for_date('ABC', Date.new(2012, 10, 13)).should == 'unknown'
    end

    it 'returns the letter at the correct position for the date' do
      vacancy.get_value_for_date('ABC', Date.new(2012, 10, 10)).should == 'A'
      vacancy.get_value_for_date('ABC', Date.new(2012, 10, 11)).should == 'B'
      vacancy.get_value_for_date('ABC', Date.new(2012, 10, 12)).should == 'C'
    end
  end
end
