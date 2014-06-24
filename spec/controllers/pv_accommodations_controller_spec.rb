require 'rails_helper'

describe PvAccommodationsController do
  let(:website) { double(Website).as_null_object }

  before { Website.stub(:first).and_return(website) }

  context 'when signed in as admin' do
    before { signed_in_as_admin }

    describe 'POST import_accommodations' do
      let(:importer)   { double(PierreEtVacances::AccommodationImporter).as_null_object }
      let(:ftp_double) { double(PierreEtVacances::FTP).as_null_object }

      before { PierreEtVacances::FTP.stub(:new).and_return(ftp_double) }

      it 'instantiates an accommodation importer' do
        PierreEtVacances::AccommodationImporter.should_receive(:new).and_return(importer)
        post 'import_accommodations'
      end

      it 'gets the data from FTP' do
        PierreEtVacances::AccommodationImporter.stub(:new).and_return(importer)
        ftp_double.should_receive(:get)
        post 'import_accommodations'
      end

      it 'imports the data' do
        PierreEtVacances::AccommodationImporter.stub(:new).and_return(importer)
        ftp_double.stub(:xml_filename).and_return('a.xml')
        importer.should_receive(:import).with(['pierreetvacances/a.xml'], true)
        post 'import_accommodations'
      end

      it 'redirects to index' do
        PierreEtVacances::AccommodationImporter.stub(:new).and_return(importer)
        post 'import_accommodations'
        expect(response).to redirect_to(action: 'index')
      end

      it 'sets a flash notice' do
        PierreEtVacances::AccommodationImporter.stub(:new).and_return(importer)
        post 'import_accommodations'
        expect(flash[:notice]).to eq 'Pierre et Vacances accommodations have been imported.'
      end
    end
  end
end
