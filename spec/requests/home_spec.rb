require 'rails_helper'

RSpec.describe 'Home', type: :request do
  before { FactoryGirl.create(:website) }

  describe 'GET /home/search' do
    before { get '/home/search', params: { place_name: place_name } }

    context 'when given neither a region or a resort' do
      let(:place_name) { nil }
      it 'redirects to the home page' do
        expect(response).to redirect_to root_path
      end
    end

    context 'with place_name set' do
      context 'to a resort name`' do
        let(:resort) { FactoryGirl.create(:resort) }
        let(:place_name) { resort.name }

        it 'redirects to the resort\'s page' do
          expect(response).to redirect_to(resort_property_rent_path(resort))
        end
      end

      context 'to a region name' do
        let(:region) { FactoryGirl.create(:region) }
        let(:place_name) { region.name }

        it 'redirects to the region\'s page' do
          expect(response).to redirect_to(region_property_rent_path(region))
        end
      end
    end
  end
end
