require 'spec_helper'

describe AirportDistancesController do
  let(:website) { mock_model(Website).as_null_object }
  let(:current_user) { mock_model(User).as_null_object }
  let(:airport_distance) { mock_model(AirportDistance).as_null_object }

  before do
    Website.stub(:first).and_return(website)
    session[:user] = 1
    User.stub(:find_by_id).and_return(current_user)
  end

  describe 'GET index' do
    it 'finds all airport distances' do
      AirportDistance.should_receive(:all)
      get 'index'
    end

    it 'assigns @airport_distances' do
      AirportDistance.stub(:all).and_return([airport_distance])
      get 'index'
      assigns(:airport_distances).should == [airport_distance]
    end
  end

  describe 'GET new' do
    it 'instantiates a new airport distance' do
      AirportDistance.should_receive(:new)
      get 'new'
    end

    it 'assigns a new airport distance' do
      AirportDistance.stub(:new).and_return(airport_distance)
      get 'new'
      assigns(:airport_distance).should == airport_distance
    end
  end

  def post_params
    { airport_distance: { 'airport_id' => '1', 'distance_km' => '20', 'resort_id' => '1' } }
  end

  describe 'POST create' do
    it 'instantiates a new airport distance with the given params' do
      AirportDistance.should_receive(:new).with(post_params[:airport_distance])
        .and_return(airport_distance)
      post 'create', post_params
    end

    context 'when the airport distance saves' do
      before do
        AirportDistance.stub(:new).and_return(airport_distance)
        airport_distance.stub(:save).and_return(true)
      end
      
      it 'redirects to index' do
        post 'create', post_params
        response.should redirect_to(action: 'index')
      end

      it 'sets a notice' do
        post 'create', post_params
        flash[:notice].should == I18n.t('notices.created')
      end
    end

    context 'when the airport distance fails to save' do
      before do
        AirportDistance.stub(:new).and_return(airport_distance)
        airport_distance.stub(:save).and_return(false)
      end

      it 'renders new' do
        post 'create', post_params
        response.should render_template('new')
      end
    end
  end

  describe 'GET edit' do
    it 'finds the airport distance' do
      should_find_airport_distance
      get 'edit', { 'id' => '1' }
    end

    it 'assigns @airport_distance' do
      AirportDistance.stub(:find).and_return(airport_distance)
      get 'edit', { 'id' => '1' }
      assigns(:airport_distance).should == airport_distance
    end
  end

  def should_find_airport_distance
    AirportDistance.should_receive(:find).and_return(airport_distance)
  end

  def put_params
    { 'id' => '1', 'airport_distance' => { 'distance_km' => '90' } }
  end

  describe 'PUT update' do
    it 'finds the airport distance' do
      should_find_airport_distance
      put 'update', put_params
    end

    it 'updates the airport distance' do
      AirportDistance.stub(:find).and_return(airport_distance)
      airport_distance.should_receive(:update_attributes).with(put_params['airport_distance'])
      put 'update', put_params
    end

    context 'when the airport distance saves' do
      before do
        AirportDistance.stub(:find).and_return(airport_distance)
        airport_distance.stub(:update_attributes).and_return(true)
      end

      it 'redirects to index' do
        put 'update', put_params
        response.should redirect_to(action: 'index')
      end

      it 'sets a notice' do
        put 'update', put_params
        flash[:notice].should == I18n.t('notices.saved')
      end
    end

    context 'when the airport distance fails to save' do
      before do
        AirportDistance.stub(:find).and_return(airport_distance)
        airport_distance.stub(:update_attributes).and_return(false)
      end

      it 'renders edit' do
        put 'update', put_params
        response.should render_template('edit')
      end

      it 'assigns @airport_distance' do
        put 'update', put_params
        assigns(:airport_distance).should == airport_distance
      end
    end
  end

  describe 'DELETE destroy' do
    it 'finds the airport distance' do
      should_find_airport_distance
      delete 'destroy', { 'id' => '1' }
    end

    it 'destroys the airport distance' do
      AirportDistance.stub(:find).and_return(airport_distance)
      airport_distance.should_receive(:destroy)
      delete 'destroy', { 'id' => '1' }
    end

    it 'redirects to index' do
      AirportDistance.stub(:find).and_return(airport_distance)
      delete 'destroy', { 'id' => '1' }
      response.should redirect_to(action: 'index')
    end

    it 'sets a notice' do
      AirportDistance.stub(:find).and_return(airport_distance)
      delete 'destroy', { 'id' => '1' }
      flash[:notice].should == I18n.t('notices.deleted')
    end
  end
end
