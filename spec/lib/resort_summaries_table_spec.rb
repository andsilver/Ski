require 'spec_helper'

describe ResortSummariesTable do
  def rst(country = Country.new)
    @rst || ResortSummariesTable.new(country)
  end

  let(:country) { FactoryGirl.create(:country) }
  let(:resort_x) { Resort.create!(name: 'X', altitude_m: 1600, top_lift_m: 2100, piste_length_km: 1200, visible: true, slug: 'x') }
  let(:resort_y) { Resort.create!(name: 'Y', visible: true, slug: 'y') }

  describe '#headers' do
    it 'returns an array of headers' do
      expect(rst.headers).to eq ['Resort', 'Altitude', 'Top lift', 'Piste (km)', 'Nearest airport', 'Distance']
    end
  end

  describe '#rows' do
    it 'returns one row per resort' do
      country.resorts << resort_x
      country.resorts << resort_y
      expect(rst(country).rows.count).to eq 2
    end

    it 'excludes invisible resorts' do
      country.resorts << resort_x
      country.resorts << Resort.create!(name: 'Z', visible: false, slug: 'z')
      expect(rst(country).rows.count).to eq 1
    end

    it 'returns resort in cell 0' do
      country.resorts << resort_x
      expect(rst(country).rows.first[0]).to eq resort_x
    end

    it 'returns altitude in cell 1' do
      country.resorts << resort_x
      expect(rst(country).rows.first[1]).to eq resort_x.altitude_m
    end

    it 'returns top lift in cell 2' do
      country.resorts << resort_x
      expect(rst(country).rows.first[2]).to eq resort_x.top_lift_m
    end

    it 'returns ski area in cell 3' do
      country.resorts << resort_x
      expect(rst(country).rows.first[3]).to eq resort_x.piste_length_km
    end

    it 'returns nearest airport name in cell 4' do
      country.resorts << resort_x
      create_airport
      expect(rst(country).rows.first[4]).to eq 'Robin Hood Airport'
    end

    it 'returns nearest airport distance in cell 5' do
      country.resorts << resort_x
      create_airport
      expect(rst(country).rows.first[5]).to eq 100
    end

    def create_airport
      a = Airport.create!(name: 'Robin Hood Airport', code: 'DSA', country_id: country.id)
      ad = AirportDistance.create!(resort_id: resort_x.id, airport_id: a.id, distance_km: 100)
    end
  end
end
