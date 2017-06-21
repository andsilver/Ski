require 'rails_helper'

module TripAdvisor
  RSpec.describe LocationFileImporter do
    describe '#import' do
      it 'opens the file at path and asks LocationImporter to import it' do
        path = 'path/to/locations.json'
        io = instance_double(IO)
        li = instance_double(LocationImporter)

        expect(File).to receive(:open).with(path).and_yield(io)
        expect(LocationImporter).to receive(:new).with(io).and_return(li)
        expect(li).to receive(:import)

        sut = LocationFileImporter.new(path: path)
        sut.import
      end
    end
  end
end
