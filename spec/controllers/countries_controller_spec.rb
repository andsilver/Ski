require 'spec_helper'

describe CountriesController do
  let(:website) { mock_model(Website).as_null_object }
  let(:country) { mock_model(Country).as_null_object }

  before do
    Website.stub(:first).and_return(website)
  end

  describe 'GET show' do
    it 'finds the country by its slug' do
      Country.should_receive(:find_by).with(slug: 'france').and_return(country)
      get 'show', id: 'france'
    end

    context 'when country not found by slug' do
      before do
        Country.stub(:find_by).with(slug: 'france').and_return nil
      end

      it 'finds a country by its ID' do
        Country.should_receive(:find_by).with(id: 'france')
        get :show, id: 'france'
      end

      context 'when country found by its ID' do
        before do
          Country.should_receive(:find_by).with(id: 'france').and_return country
        end

        it 'permanently redirects to that country' do
          get :show, id: 'france'
          expect(response).to redirect_to country
          expect(response.status).to eq 301
        end
      end

      context 'when the country is not found' do
        before { Country.stub(:find_by).and_return(nil) }

        it 'renders 404' do
          get 'show', id: 'france'
          expect(response.status).to eq 404
        end
      end
    end
  end
end
