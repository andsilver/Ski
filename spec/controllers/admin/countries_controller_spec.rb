require 'rails_helper'

describe Admin::CountriesController do
  let(:website) { double(Website).as_null_object }

  before do
    allow(Website).to receive(:first).and_return(website)
  end

  def mock_country
    @mock_country ||= double(Country)
  end

  context 'when signed in as admin' do
    before { signed_in_as_admin }

    describe 'GET index' do
      it 'assigns all countries ordered by name to @countries' do
        countries = [mock_country]
        expect(Country).to receive(:order).with('name').and_return(countries)
        get 'index'
        expect(assigns(:countries)).to eq countries
      end
    end

    describe 'GET new' do
      it 'assigns a new instance of Country to @country' do
        expect(Country).to receive(:new).and_return(mock_country)
        get 'new'
        expect(assigns(:country)).to eq mock_country
      end
    end

    describe 'POST create' do
      pending
    end

    describe 'GET edit' do
      pending
    end

    describe 'POST update' do
      pending
    end

    describe 'DELETE destroy' do
      let(:country) { FactoryGirl.create(:country) }

      it 'deletes a country' do
        delete :destroy, id: country.to_param
        expect(Country.find_by(id: country.id)).to_not be
      end

      it 'redirects to countries admin page' do
        delete :destroy, id: country.to_param
        expect(response).to redirect_to admin_countries_path
      end
    end
  end
end
