require 'spec_helper'

describe ResortSummariesTable do
  def rst(country = Country.new)
    @rst || ResortSummariesTable.new(country)
  end

  let(:country) { FactoryGirl.create(:country) }
  let(:resort_x) { Resort.create!(name: 'X', altitude_m: 1600, top_lift_m: 2100, ski_area_km: 1200) }
  let(:resort_y) { Resort.create!(name: 'Y') }

  describe '#headers' do
    it 'returns an array of headers' do
      rst.headers.should == ['Resort', 'Altitude', 'Top lift', 'Ski area', 'Nearest airport', 'Distance']
    end
  end

  describe '#rows' do
    it 'returns one row per resort' do
      country.resorts << resort_x
      country.resorts << resort_y
      rst(country).rows.count.should eq 2
    end

    it 'returns resort in cell 0' do
      country.resorts << resort_x
      rst(country).rows.first[0].should eq resort_x
    end

    it 'returns altitude in cell 1' do
      country.resorts << resort_x
      rst(country).rows.first[1].should eq resort_x.altitude_m
    end

    it 'returns top lift in cell 2' do
      country.resorts << resort_x
      rst(country).rows.first[2].should eq resort_x.top_lift_m
    end

    it 'returns ski area in cell 3' do
      country.resorts << resort_x
      rst(country).rows.first[3].should eq resort_x.ski_area_km
    end

    it 'returns nearest airport name in cell 4' do
      country.resorts << resort_x
      create_airport
      rst(country).rows.first[4].should eq 'Robin Hood Airport'
    end

    it 'returns nearest airport distance in cell 5' do
      country.resorts << resort_x
      create_airport
      rst(country).rows.first[5].should eq 100
    end

    def create_airport
      a = Airport.create!(name: 'Robin Hood Airport', code: 'DSA', country_id: country.id)
      ad = AirportDistance.create!(resort_id: resort_x.id, airport_id: a.id, distance_km: 100)
    end
  end
end
