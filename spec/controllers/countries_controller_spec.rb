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

    context 'when the country is not found' do
      before { Country.stub(:find_by).and_return(nil) }

      it 'renders 404' do
        get 'show', id: 'france'
        expect(response.status).to eq 404
      end
    end
  end
end
