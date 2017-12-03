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

      context 'with malformed JSON' do
        let(:importer) { PropertyImporter.new(json(1_941_864)) }

        it 'does not persist the property' do
          importer.import
          expect(TripAdvisorProperty.exists?(1_941_864)).to be_falsey
        end

        it 'logs a warning' do
          expect(Rails.logger)
            .to receive(:warn)
            .with('Malformed JSON found in TripAdvisor::PropertyImporter')
          importer.import
        end
      end

      it 'copies details' do
        details = instance_double(
          PropertyDetails, property: TripAdvisorProperty.new
        ).as_null_object
        expect(PropertyDetails)
          .to receive(:new)
          .with(JSON.parse(json))
          .and_return(details)
        expect(details).to receive(:import)

        null_object(BaseProperty)
        null_object(LongTermAdvert)
        null_object(PropertyImages)

        importer = PropertyImporter.new(json)
        importer.import
      end

      context 'when TA property persisted' do
        let(:ta_prop) { instance_double(TripAdvisorProperty, persisted?: true, id: 123) }

        it 'imports the calendar' do
          details = instance_double(PropertyDetails, property: ta_prop)
                    .as_null_object
          allow(PropertyDetails).to receive(:new).and_return(details)

          pci = instance_double(PropertyCalendarImporter)
          expect(PropertyCalendarImporter)
            .to receive(:new)
            .with(123, JSON.parse(json)['calendar'])
            .and_return(pci)
          expect(pci).to receive(:import)

          null_object(BaseProperty)
          null_object(LongTermAdvert)
          null_object(PropertyImages)

          importer = PropertyImporter.new(json)
          importer.import
        end

        it 'creates a base property' do
          details = instance_double(PropertyDetails, property: ta_prop)
                    .as_null_object
          allow(PropertyDetails).to receive(:new).and_return(details)

          bp = instance_double(BaseProperty)
          expect(BaseProperty).to receive(:new).with(ta_prop).and_return(bp)
          expect(bp).to receive(:create).with(TripAdvisor.user)

          null_object(PropertyCalendarImporter)
          null_object(LongTermAdvert)
          null_object(PropertyImages)

          importer = PropertyImporter.new(json)
          importer.import
        end

        it 'advertises the property' do
          details = instance_double(PropertyDetails, property: ta_prop)
                    .as_null_object
          allow(PropertyDetails).to receive(:new).and_return(details)

          prop = Property.new
          allow(BaseProperty)
            .to receive(:new)
            .and_return(instance_double(BaseProperty, create: prop))

          lta = instance_double(LongTermAdvert)
          expect(LongTermAdvert).to receive(:new).with(prop).and_return(lta)
          expect(lta).to receive(:create)

          null_object(PropertyCalendarImporter)
          null_object(PropertyImages)

          importer = PropertyImporter.new(json)
          importer.import
        end

        it 'imports images' do
          details = instance_double(PropertyDetails, property: ta_prop)
                    .as_null_object
          allow(PropertyDetails).to receive(:new).and_return(details)

          prop = Property.new
          allow(BaseProperty)
            .to receive(:new)
            .and_return(instance_double(BaseProperty, create: prop))

          pi = instance_double(PropertyImages)
          expect(PropertyImages)
            .to receive(:new).with(prop, json).and_return(pi)
          expect(pi).to receive(:import)

          null_object(PropertyCalendarImporter)
          null_object(LongTermAdvert)

          importer = PropertyImporter.new(json)
          importer.import
        end
      end

      context 'when TA property not persisted' do
        let(:ta_prop) do
          instance_double(TripAdvisorProperty, persisted?: false)
        end

        it 'does not create a base property' do
          details = instance_double(PropertyDetails, property: ta_prop)
                    .as_null_object
          allow(PropertyDetails).to receive(:new).and_return(details)

          expect(BaseProperty).not_to receive(:new)

          importer = PropertyImporter.new(json)
          importer.import
        end
      end
    end
  end
end
