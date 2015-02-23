require 'rails_helper'

describe RegionsController do
  let(:website) { double(Website).as_null_object }
  let(:region) { double(Region).as_null_object }

  before do
    allow(Website).to receive(:first).and_return(website)
    allow(controller).to receive(:admin?).and_return(false)
  end

  shared_examples "a user of a region" do
    it 'finds a region by its slug' do
      expect(Region).to receive(:find_by).with(slug: 'lake-como')
      get :show, id: 'lake-como'
    end

    it 'assigns @region' do
      allow(Region).to receive(:find_by).and_return(region)
      get :show, id: 'lake-como'
      expect(assigns[:region]).to equal(region)
    end

    context 'when region found' do
      before { allow(Region).to receive(:find_by).and_return(region) }

      it 'gets featured properties for the region' do
        expect(region).to receive(:featured_properties)
        get :show, id: 'lake-como'
      end

      it 'assigns @featured_properties' do
        allow(region).to receive(:featured_properties).and_return(:featured_properties)
        get :show, id: 'lake-como'
        expect(assigns(:featured_properties)).to eq :featured_properties
      end
    end

    context 'when region not found' do
      it 'renders 404' do
        get :show, id: 'lake-como'
        expect(response.status).to eq 404
      end
    end
  end

  describe 'GET show' do
    it_behaves_like "a user of a region"
  end

  describe 'GET how_to_get_there' do
    it_behaves_like "a user of a region"

    context 'when region found' do
      before { allow(Region).to receive(:find_by).and_return(region) }

      context 'when @page_content is set' do
        before { controller.instance_variable_set(:@page_content, 'some content') }

        it 'renders 200' do
          get :how_to_get_there, id: 'lake-como'
          expect(response.status).to eq 200
        end
      end

      context 'when @page_content is blank' do
        it 'renders 404' do
          get :how_to_get_there, id: 'lake-como'
          expect(response.status).to eq 404
        end
      end
    end
  end
end
