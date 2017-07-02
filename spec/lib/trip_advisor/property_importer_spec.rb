require 'rails_helper'

module TripAdvisor
  RSpec.describe PropertyImporter do
    def json(id = 7_363_690)
      File.read(
        File.join(
          Rails.root, 'test-files', 'trip_advisor', 'properties', "#{id}.json"
        )
      )
    end

    describe '#import' do
      let(:property) { TripAdvisorProperty.last }
      let(:importer) { PropertyImporter.new(json) }

      before { importer.import }

      it 'creates a TripAdvisor property with specified ID' do
        expect(TripAdvisorProperty.exists?(7_363_690)).to be_truthy
      end

      it 'updates an existing TripAdvisorProperty' do
        importer.import # run a second time
      end

      it 'sets number of bedrooms' do
        expect(property.bedrooms).to eq 6
      end

      it 'sets number of beds' do
        expect(property.beds).to eq 9
      end

      it 'sets sleeping capacity' do
        expect(property.sleeps).to eq 16
      end

      it 'sets number of bathrooms' do
        expect(property.bathrooms).to eq 2
      end

      it 'sets country' do
        expect(property.country).to eq 'France'
      end

      it 'sets city' do
        expect(property.city).to eq 'Le Thillot'
      end

      it 'sets URL' do
        expect(property.url).to eq 'https://www.tripadvisor.com/FeaturedRenta' \
          'lReview?geo=672998&detail=10484294'
      end

      it 'sets status' do
        expect(property.status).to eq 'ONLINE'
      end

      it 'sets review_average' do
        expect(property.review_average).to eq 5.0
      end

      it 'sets show_pin' do
        expect(property.show_pin?).to be_truthy
      end

      it 'sets lat_long' do
        expect(property.lat_long).to eq '47.89399 6.77065'
      end

      it 'sets country_code' do
        expect(property.country_code).to eq 'FR'
      end

      it 'sets trip_advisor_location_id ta_geo_location_id' do
        expect(property.trip_advisor_location_id).to eq 672_998
      end

      it 'sets postal_code' do
        expect(property.postal_code).to eq '88160'
      end

      it 'sets search_url' do
        expect(property.search_url).to eq 'http://www.tripadvisor.com/VRACSea' \
          'rch?geo=672998&firstVRs=10484294'
      end

      it 'sets can_accept_inquiry' do
        expect(property.can_accept_inquiry?).to be_truthy
      end

      it 'sets booking_option' do
        expect(property.booking_option).to eq 'TIP'
      end

      it 'sets min_stay_high' do
        expect(property.min_stay_high).to eq 7
      end

      it 'sets min_stay_low' do
        expect(property.min_stay_low).to eq 2
      end
    end
  end
end
