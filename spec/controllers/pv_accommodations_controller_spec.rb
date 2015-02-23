require 'rails_helper'

describe PvAccommodationsController do
  let(:website) { double(Website).as_null_object }

  before { allow(Website).to receive(:first).and_return(website) }

  context 'when signed in as admin' do
    before { signed_in_as_admin }

    describe 'POST import_accommodations' do
      let(:importer)   { double(PierreEtVacances::AccommodationImporter).as_null_object }
      let(:ftp_double) { double(PierreEtVacances::FTP).as_null_object }

      before { allow(PierreEtVacances::FTP).to receive(:new).and_return(ftp_double) }

      it 'instantiates an accommodation importer' do
        expect(PierreEtVacances::AccommodationImporter).to receive(:new).and_return(importer)
        post 'import_accommodations'
      end

      it 'gets the data from FTP' do
        allow(PierreEtVacances::AccommodationImporter).to receive(:new).and_return(importer)
        expect(ftp_double).to receive(:get)
        post 'import_accommodations'
      end

      it 'imports the data' do
        allow(PierreEtVacances::AccommodationImporter).to receive(:new).and_return(importer)
        allow(ftp_double).to receive(:xml_filename).and_return('a.xml')
        expect(importer).to receive(:import).with(['pierreetvacances/a.xml'])
        post 'import_accommodations'
      end

      it 'redirects to index' do
        allow(PierreEtVacances::AccommodationImporter).to receive(:new).and_return(importer)
        post 'import_accommodations'
        expect(response).to redirect_to(action: 'index')
      end

      it 'sets a flash notice' do
        allow(PierreEtVacances::AccommodationImporter).to receive(:new).and_return(importer)
        post 'import_accommodations'
        expect(flash[:notice]).to eq 'Pierre et Vacances accommodations have been imported.'
      end
    end
  end
end
