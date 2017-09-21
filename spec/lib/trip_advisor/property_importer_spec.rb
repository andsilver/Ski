# frozen_string_literal: true

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
      def null_object(klass)
        allow(klass)
          .to receive(:new)
          .and_return(instance_double(klass).as_null_object)
      end

      it 'copies details' do
        details = instance_double(PropertyDetails).as_null_object
        expect(PropertyDetails).to receive(:new).with(json).and_return(details)
        expect(details).to receive(:import)

        null_object(BaseProperty)
        null_object(LongTermAdvert)

        importer = PropertyImporter.new(json)
        importer.import
      end

      it 'creates a base property' do
        ta_prop = TripAdvisorProperty.new
        details = instance_double(PropertyDetails, property: ta_prop)
          .as_null_object
        allow(PropertyDetails).to receive(:new).and_return(details)

        bp = instance_double(BaseProperty)
        expect(BaseProperty).to receive(:new).with(ta_prop).and_return(bp)
        expect(bp).to receive(:create).with(Currency.euro, TripAdvisor.user)

        null_object(LongTermAdvert)

        importer = PropertyImporter.new(json)
        importer.import
      end

      it 'advertises the property' do
        ta_prop = TripAdvisorProperty.new
        details = instance_double(PropertyDetails).as_null_object
        allow(PropertyDetails).to receive(:new).and_return(details)

        prop = Property.new
        allow(BaseProperty)
          .to receive(:new)
          .and_return(instance_double(BaseProperty, create: prop))

        lta = instance_double(LongTermAdvert)
        expect(LongTermAdvert).to receive(:new).with(prop).and_return(lta)
        expect(lta).to receive(:create)

        importer = PropertyImporter.new(json)
        importer.import
      end
    end
  end
end
