# frozen_string_literal: true

require 'rails_helper'

module TripAdvisor
  RSpec.describe PropertyDetails do
    def json(id = 7_363_690)
      File.read(
        File.join(
          Rails.root, 'test-files', 'trip_advisor', 'properties', "#{id}.json"
        )
      )
    end

    describe '#import' do
      let!(:eur) { FactoryGirl.create(:currency, code: 'EUR') }
      let(:property) { TripAdvisorProperty.last }
      let(:details) { PropertyDetails.new(json) }

      before { details.import }

      it 'creates a TripAdvisor property with specified ID' do
        expect(TripAdvisorProperty.exists?(7_363_690)).to be_truthy
      end

      it 'updates an existing TripAdvisorProperty' do
        details.import # run a second time
      end

      it 'sets the title' do
        expect(property.title).to eq('CHALET 16 PERS ACTIVITIES FREE POOL / ' \
          'SPA BAR PANCAKES, PARK GAMES GIANT ...')
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

      it 'sets starting_price' do
        expect(property.starting_price).to eq 112
      end

      it 'sets currency' do
        expect(property.currency).to eq eur
      end

      it 'sets min_stay_high' do
        expect(property.min_stay_high).to eq 7
      end

      it 'sets min_stay_low' do
        expect(property.min_stay_low).to eq 2
      end
    end

    describe '#property' do
      let!(:eur) { FactoryGirl.create(:currency, code: 'EUR') }

      it 'creates a new TripAdvisorProperty with id equal to TripAdvisor id' do
        prop = PropertyDetails.new(json).property
        expect(prop.class).to eq TripAdvisorProperty
        expect(prop.new_record?).to be_truthy
      end

      it 'finds an existing TripAdvisorProperty with matching id' do
        existing = FactoryGirl.create(:trip_advisor_property, id: 7_363_690)
        prop = PropertyDetails.new(json).property
        expect(prop).to eq existing
      end
    end
  end
end
