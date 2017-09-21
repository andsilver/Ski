# frozen_string_literal: true

require 'rails_helper'

module TripAdvisor
  RSpec.describe BaseProperty do
    describe '#create' do
      let(:user) { FactoryGirl.create(:user) }
      let(:resort) { FactoryGirl.create(:resort) }
      let(:ta_prop) do
        FactoryGirl.create(
          :trip_advisor_property,
          sleeps: 8,
          id: 1
        )
      end
      let(:currency) { FactoryGirl.create(:currency) }

      before do
        allow(ta_prop).to receive(:resort).and_return(resort)
        @property = BaseProperty.new(ta_prop).create(currency, user)
      end

      it 'creates a property' do
        expect(Property.count).to eq 1
      end

      it 'sets the resort to the TripAdvisorProperty resort' do
        expect(@property.resort).to eq resort
      end

      it 'sets the currency to the currency param' do
        expect(@property.currency).to eq currency
      end

      it 'sets the user to the user param' do
        expect(@property.user).to eq user
      end

      it 'sets the trip_advisor_property association' do
        expect(@property.trip_advisor_property).to eq ta_prop
      end

      it 'sets the property as for rent' do
        expect(@property.listing_type).to eq Property::LISTING_TYPE_FOR_RENT
      end

      it 'sets the sleeping capacity' do
        expect(@property.sleeping_capacity).to eq 8
      end
    end
  end
end
