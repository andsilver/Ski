require 'spec_helper'

describe Admin::CountriesController do
  let(:website) { mock_model(Website).as_null_object }

  before do
    Website.stub(:first).and_return(website)
  end

  def mock_country
    @mock_country ||= mock_model(Country)
  end

  context 'when signed in as admin' do
    before { signed_in_as_admin }

    describe 'GET index' do
      it 'assigns all countries ordered by name to @countries' do
        countries = [mock_country]
        Country.should_receive(:order).with('name').and_return(countries)
        get 'index'
        expect(assigns(:countries)).to eq countries
      end
    end

    describe 'GET new' do
      it 'assigns a new instance of Country to @country' do
        Country.should_receive(:new).and_return(mock_country)
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
      pending
    end
  end
end
