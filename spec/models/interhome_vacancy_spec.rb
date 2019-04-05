require "rails_helper"

describe InterhomeVacancy do
  let(:vacancy) { InterhomeVacancy.new(startday: Date.new(2012, 10, 10)) }

  describe "#minstay_on" do
    before do
      # 0 - not bookable
      # A - 1 day
      # B - 2 days ...
      # N - 14 days
      # Z - 26 days
      vacancy.minstay = "0ANZ"
    end

    it "returns 0 when not bookable" do
      expect(vacancy.minstay_on(Date.new(2012, 10, 10))).to eq 0
    end

    it "returns 1 for A" do
      expect(vacancy.minstay_on(Date.new(2012, 10, 11))).to eq 1
    end

    it "returns 14 for N" do
      expect(vacancy.minstay_on(Date.new(2012, 10, 12))).to eq 14
    end

    it "returns 26 for Z" do
      expect(vacancy.minstay_on(Date.new(2012, 10, 13))).to eq 26
    end

    it "returns nil for other dates" do
      expect(vacancy.minstay_on(Date.new(2012, 10, 9))).to be_nil
      expect(vacancy.minstay_on(Date.new(2012, 10, 14))).to be_nil
    end
  end

  describe "#check_in_on?" do
    before do
      # C - check-in and check-out
      # I - check-in only
      # X - no action possible
      # O - check-out only
      vacancy.changeover = "CIXO"
    end

    it "returns true when the check in value is C or I" do
      expect(vacancy.check_in_on?(Date.new(2012, 10, 10))).to be_truthy
      expect(vacancy.check_in_on?(Date.new(2012, 10, 11))).to be_truthy
    end

    it "returns false when the check in value is X or O" do
      expect(vacancy.check_in_on?(Date.new(2012, 10, 12))).to be_falsey
      expect(vacancy.check_in_on?(Date.new(2012, 10, 13))).to be_falsey
    end
  end

  describe "#available_to_check_in_on_dates?" do
    before do
      vacancy.availability = "NNYYYY"
      vacancy.changeover = "CXCICO"
    end

    it "returns false if availability is not Y" do
      vacancy.availability = "NN"
      vacancy.changeover = "CX"
      expect(vacancy.available_to_check_in_on_dates?([Date.new(2012, 10, 10), Date.new(2012, 10, 11)])).to be_falsey
    end

    it "returns true if all dates can be checked in on and are available" do
      vacancy.availability = "YY"
      vacancy.changeover = "CI"
      expect(vacancy.available_to_check_in_on_dates?([Date.new(2012, 10, 10), Date.new(2012, 10, 11)])).to be_truthy
    end

    it "returns false if any date cannot be checked in on" do
      vacancy.availability = "YY"
      vacancy.changeover = "CO"
      expect(vacancy.available_to_check_in_on_dates?([Date.new(2012, 10, 10), Date.new(2012, 10, 11)])).to be_falsey

      vacancy.availability = "NY"
      vacancy.changeover = "CC"
      expect(vacancy.available_to_check_in_on_dates?([Date.new(2012, 10, 10), Date.new(2012, 10, 11)])).to be_falsey
    end
  end

  describe "#get_value_for_date" do
    it 'returns "unknown" for dates in the past' do
      expect(vacancy.get_value_for_date("ABC", Date.new(2012, 10, 9))).to eq "unknown"
    end

    it 'returns "unknown" for dates too far in the future' do
      expect(vacancy.get_value_for_date("ABC", Date.new(2012, 10, 13))).to eq "unknown"
    end

    it "returns the letter at the correct position for the date" do
      expect(vacancy.get_value_for_date("ABC", Date.new(2012, 10, 10))).to eq "A"
      expect(vacancy.get_value_for_date("ABC", Date.new(2012, 10, 11))).to eq "B"
      expect(vacancy.get_value_for_date("ABC", Date.new(2012, 10, 12))).to eq "C"
    end
  end
end
