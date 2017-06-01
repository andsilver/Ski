require 'rails_helper'

describe Admin::AirportDistancesController do
  let(:website) { Website.new }
  let(:current_user) { FactoryGirl.build(:user) }
  let(:airport_distance) { double(AirportDistance).as_null_object }

  before do
    allow(Website).to receive(:first).and_return(website)
    allow(controller).to receive(:admin?).and_return(true)
  end

  describe 'GET index' do
    it 'finds all airport distances' do
      expect(AirportDistance).to receive(:all)
      get 'index'
    end

    it 'assigns @airport_distances' do
      pending
      allow(AirportDistance).to receive(:all).and_return([airport_distance])
      get 'index'
      expect(assigns(:airport_distances)).to eq [airport_distance]
    end
  end

  describe 'GET new' do
    it 'instantiates a new airport distance' do
      expect(AirportDistance).to receive(:new)
      get 'new'
    end

    it 'assigns a new airport distance' do
      pending
      allow(AirportDistance).to receive(:new).and_return(airport_distance)
      get 'new'
      expect(assigns(:airport_distance)).to eq airport_distance
    end
  end

  def post_params
    { airport_distance: { 'airport_id' => '1', 'distance_km' => '20', 'resort_id' => '1' } }
  end

  describe 'POST create' do
    it 'instantiates a new airport distance with the given params' do
      expect(AirportDistance).to receive(:new).with(post_params[:airport_distance])
        .and_return(airport_distance)
      post 'create', params: post_params
    end

    context 'when the airport distance saves' do
      before do
        allow(AirportDistance).to receive(:new).and_return(airport_distance)
        allow(airport_distance).to receive(:save).and_return(true)
      end

      it 'redirects to index' do
        post 'create', params: post_params
        expect(response).to redirect_to(action: 'index')
      end

      it 'sets a notice' do
        post 'create', params: post_params
        expect(flash[:notice]).to eq I18n.t('notices.created')
      end
    end

    context 'when the airport distance fails to save' do
      before do
        allow(AirportDistance).to receive(:new).and_return(airport_distance)
        allow(airport_distance).to receive(:save).and_return(false)
      end

      it 'renders new' do
        pending
        post 'create', params: post_params
        expect(response).to render_template('new')
      end
    end
  end

  describe 'GET edit' do
    it 'finds the airport distance' do
      should_find_airport_distance
      get 'edit', params: { 'id' => '1' }
    end

    it 'assigns @airport_distance' do
      pending
      allow(AirportDistance).to receive(:find).and_return(airport_distance)
      get 'edit', params: { 'id' => '1' }
      expect(assigns(:airport_distance)).to eq airport_distance
    end
  end

  def should_find_airport_distance
    expect(AirportDistance).to receive(:find).and_return(airport_distance)
  end

  def put_params
    { 'id' => '1', 'airport_distance' => { 'distance_km' => '90' } }
  end

  describe 'PUT update' do
    it 'finds the airport distance' do
      should_find_airport_distance
      put 'update', params: put_params
    end

    it 'updates the airport distance' do
      allow(AirportDistance).to receive(:find).and_return(airport_distance)
      expect(airport_distance).to receive(:update_attributes).with(put_params['airport_distance'])
      put 'update', params: put_params
    end

    context 'when the airport distance saves' do
      before do
        allow(AirportDistance).to receive(:find).and_return(airport_distance)
        allow(airport_distance).to receive(:update_attributes).and_return(true)
      end

      it 'redirects to index' do
        put 'update', params: put_params
        expect(response).to redirect_to(action: 'index')
      end

      it 'sets a notice' do
        put 'update', params: put_params
        expect(flash[:notice]).to eq I18n.t('notices.saved')
      end
    end

    context 'when the airport distance fails to save' do
      before do
        allow(AirportDistance).to receive(:find).and_return(airport_distance)
        allow(airport_distance).to receive(:update_attributes).and_return(false)
      end

      it 'renders edit' do
        pending
        put 'update', params: put_params
        expect(response).to render_template('edit')
      end

      it 'assigns @airport_distance' do
        pending
        put 'update', params: put_params
        expect(assigns(:airport_distance)).to eq airport_distance
      end
    end
  end

  describe 'DELETE destroy' do
    it 'finds the airport distance' do
      should_find_airport_distance
      delete 'destroy', params: { 'id' => '1' }
    end

    it 'destroys the airport distance' do
      allow(AirportDistance).to receive(:find).and_return(airport_distance)
      expect(airport_distance).to receive(:destroy)
      delete 'destroy', params: { 'id' => '1' }
    end

    it 'redirects to index' do
      allow(AirportDistance).to receive(:find).and_return(airport_distance)
      delete 'destroy', params: { 'id' => '1' }
      expect(response).to redirect_to(action: 'index')
    end

    it 'sets a notice' do
      allow(AirportDistance).to receive(:find).and_return(airport_distance)
      delete 'destroy', params: { 'id' => '1' }
      expect(flash[:notice]).to eq I18n.t('notices.deleted')
    end
  end
end
