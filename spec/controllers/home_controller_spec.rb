require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let(:website) { double(Website).as_null_object }

  before { allow(Website).to receive(:first).and_return(website) }

  describe 'GET search' do
    before { get :search, place_name: place_name }

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
        it 'sets the resort' do
          expect(assigns(:resort)).to eq(resort)
        end

        it 'redirects to the resort\'s page' do
          expect(response).to redirect_to(resort_property_rent_path(resort))
        end
      end

      context 'to a region name' do
        let(:region) { FactoryGirl.create(:region) }
        let(:place_name) { region.name }
        it 'sets the region' do
          expect(assigns(:region)).to eq(region)
        end

        it 'redirects to the region\'s page' do
          expect(response).to redirect_to(region_property_rent_path(region))
        end
      end
    end
  end
end
